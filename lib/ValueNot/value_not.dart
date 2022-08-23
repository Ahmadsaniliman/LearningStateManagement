import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String name;
  final String id;

  Contact({
    required this.name,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  // Singleton.
  ContactBook._sharedInstance() : super([]);
  static final _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

//   final List<Contact> _contacts = [
//     Contact(name: 'Liman'),
//     Contact(name: 'Ahmad'),
//     Contact(name: 'Sani'),
//     Contact(name: 'Sweety'),
//   ];

  void addContact({
    required Contact contact,
  }) {
    value.add(contact);
    notifyListeners();
  }

  int get length => value.length;

  Contact? contact({
    required int atIndex,
  }) {
    return value.length > atIndex ? value[atIndex] : null;
  }

  void deleteContact({
    required Contact contact,
  }) {
    value.remove(contact);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Book'),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBook,
        builder: (contact, value, child) {
          final contacts = value as List<Contact>;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Material(
                color: Colors.white,
                elevation: 7,
                child: Dismissible(
                  key: ValueKey(contact.id),
                  onDismissed: (direction) {
                    contacts.remove(contact);
                  },
                  child: ListTile(
                    title: Text(contact.name),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed('/new-name-route');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewNameView extends StatefulWidget {
  const NewNameView({Key? key}) : super(key: key);

  @override
  State<NewNameView> createState() => _NewNameViewState();
}

class _NewNameViewState extends State<NewNameView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Name'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter a new name here ...',
              contentPadding: EdgeInsetsDirectional.all(20.0),
            ),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _controller.text);
              ContactBook().addContact(contact: contact);

              Navigator.of(context).pop();
            },
            child: const Text('Add Name'),
          ),
        ],
      ),
    );
  }
}
