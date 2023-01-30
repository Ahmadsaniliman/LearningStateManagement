import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String name;
  final String number;
  final String id;

  Contact({
    required this.name,
    required this.number,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance()
      : super(
          [],
        );
  static final _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get length => value.length;

  void addContact({
    required Contact contact,
  }) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  void removeContact({
    required Contact contact,
  }) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({
    required int atIndex,
  }) =>
      value.length > atIndex ? value[atIndex] : null;
}

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Page'),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/new-Contact-Route");
        },
        icon: const Icon(Icons.add),
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
                    key: ValueKey(contact.id),
                    onDismissed: (direction) {
                      contacts.remove(contact);
                    },
                    child: Material(
                      elevation: 7.0,
                      child: ListTile(
                        minVerticalPadding: 5.0,
                        title: Text(contact.name),
                        subtitle: Text(contact.number),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({Key? key}) : super(key: key);

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  @override
  void initState() {
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 25.0,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(),
              ),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    border: InputBorder.none,
                    hintText: 'Enter Your Name'),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(),
              ),
              child: TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    border: InputBorder.none,
                    hintText: 'Enter Your Number'),
              ),
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                final contact = Contact(
                  number: _numberController.text,
                  name: _nameController.text,
                );
                if (_nameController.text.isNotEmpty &&
                    _numberController.text.isNotEmpty) {
                  ContactBook().addContact(contact: contact);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
