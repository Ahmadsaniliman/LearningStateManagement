import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Contact {
  final String name;
  final String id;

  Contact({required this.name}) : id = const Uuid().v4();
}

class ContactBook {
  ContactBook._sharedInstance();
  static final ContactBook _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  int get length => _contacts.length;

  final List<Contact> _contacts = [];

  void addContact({required Contact contact}) {
    _contacts.add(contact);
    // notifyListe
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
