import 'package:flutter/material.dart';

class Contact {
  final int id;
  final String firstName;
  final String number;

  Contact({
    required this.id,
    required this.firstName,
    required this.number,
  });
}

class ContactBook {
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  // Get Length of Contact.
  int get length => _contacts.length;

  // Conatct Storage
  final List<Contact> _contacts = [
    Contact(
      id: 1,
      firstName: 'Ahmad',
      number: 08088405841.toString(),
    ),
  ];

  //Add Conatact.
  void addContact({
    required Contact contact,
  }) {
    _contacts.add(contact);
  }

  // Remove Contact.
  void removeContact({
    required Contact contact,
  }) {
    _contacts.remove(contact);
  }

  // Not For Now
  Contact? contact({
    required int atIndex,
  }) {
    return _contacts.length > atIndex ? _contacts[atIndex] : null;
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
      body: ListView.builder(
        itemCount: contactBook.length,
        itemBuilder: (context, index) {
          final contact = contactBook.contact(atIndex: index);
          return ListTile(
            leading: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text('${contact!.id}'),
            ),
            title: Text(
              contact.firstName,
            ),
            subtitle: Text('$contact.number'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewContactPage extends StatefulWidget {
  const NewContactPage({Key? key}) : super(key: key);

  @override
  _NewContactPageState createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _numberController;
//   late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _numberController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact Bar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldCont(
              controller: _firstNameController,
              text: 'Enter Your First Name',
              type: TextInputType.emailAddress,
            ),
            TextFieldCont(
              controller: _numberController,
              text: 'Enter Your Number',
              type: TextInputType.number,
            ),
            TextButton(
              onPressed: () {
                final contact = Contact(
                  id: 1,
                  firstName: _firstNameController.text,
                  number: _numberController.text,
                );
                ContactBook().addContact(
                  contact: contact,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldCont extends StatelessWidget {
  const TextFieldCont({
    Key? key,
    required TextEditingController controller,
    required this.text,
    required this.type,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String text;
  final TextInputType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        controller: _controller,
        keyboardType: type,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(
            20.0,
          ),
          hintText: text,
        ),
      ),
    );
  }
}
