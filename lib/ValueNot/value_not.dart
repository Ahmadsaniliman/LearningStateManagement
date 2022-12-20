import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String id;
  final String firstName;
  final String number;

  Contact({
    required this.firstName,
    required this.number,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  // Get Length of Contact.
  int get length => value.length;

  //Add Conatact.
  void addContact({
    required Contact contact,
  }) {
    final contacts = value;
    contacts.add(contact);
    notifyListeners();
  }

  // Remove Contact.
  void removeContact({
    required Contact contact,
  }) {
    final contacts = value;
    if (contacts.contains(contact)) {
      contacts.remove(contact);
      notifyListeners();
    }
  }

  // Not For Now
  Contact? contact({
    required int atIndex,
  }) {
    return value.length > atIndex ? value[atIndex] : null;
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
    // final contactBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Book'),
      ),
      body: ValueListenableBuilder(
          valueListenable: ContactBook(),
          builder: (contact, value, context) {
            final contacts = value as List<Contact>;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Dismissible(
                  key: ValueKey(contact.id),
                  onDismissed: (diection) {
                    ContactBook().removeContact(contact: contact);
                  },
                  child: ListTile(
                    leading: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Center(
                        child: Text(contact.id),
                      ),
                    ),
                    title: Text(
                      contact.firstName,
                    ),
                    subtitle: Text(contact.number),
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).pushNamed("/new-Contact-Route");
        },
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldCont(
                controller: _firstNameController,
                text: 'Enter Your First Name',
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20.0),
              TextFieldCont(
                controller: _numberController,
                text: 'Enter Your Number',
                type: TextInputType.number,
              ),
              TextButton(
                onPressed: () {
                  final contact = Contact(
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
