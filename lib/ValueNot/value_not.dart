import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String name;
  final String id;

  Contact({required this.name}) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInnstance() : super([]);
  static final _shared = ContactBook._sharedInnstance();
  factory ContactBook() => _shared;

  int get length => value.length;

  void addContact({required Contact contact}) {
    value.add(contact);
    notifyListeners();
  }

  void removeContact({required Contact contact}) {
    if (value.contains(contact)) {
      value.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({required int atIndex}) =>
      value.length > atIndex ? value[atIndex] : null;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactBook HomePage'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (contact, value, child) {
          final contacts = value as List<Contact>;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Dismissible(
                onDismissed: (direction) => contacts.remove(contact),
                key: ValueKey(contact.id),
                child: Material(
                  elevation: 6.0,
                  color: Colors.white70,
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
        onPressed: () {
          Navigator.of(context).pushNamed("/new-Contact-Route");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddConatctPage extends StatefulWidget {
  const AddConatctPage({Key? key}) : super(key: key);

  @override
  State<AddConatctPage> createState() => _AddConatctPageState();
}

class _AddConatctPageState extends State<AddConatctPage> {
  late final TextEditingController _nameController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Your Name Please',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final contact = Contact(name: _nameController.text);
              ContactBook().addContact(contact: contact);
              Navigator.of(context).pop();
            },
            child: const Text('save'),
          ),
        ],
      ),
    );
  }
}
