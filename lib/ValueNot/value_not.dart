import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String id;
  final String number;
  final String name;

  Contact({
    required this.number,
    required this.name,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  ContactBook._sharedInstance() : super([]);
  static final _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];
  int get lenght => value.length;

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
      _contacts.remove(contact);
      notifyListeners();
    }
  }

  Contact? contact({
    required int atIndex,
  }) {
    _contacts.length > atIndex ? _contacts[atIndex] : null;
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Eneter Your Name'),
            ),
          ),
          Container(
            width: double.infinity,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Eneter Your Number'),
            ),
          ),
        ],
      ),
    );
  }
}
