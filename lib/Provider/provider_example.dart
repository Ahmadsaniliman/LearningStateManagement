import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BreadCrumb {
  bool isActive;
  final String name;
  final String uuid;

  BreadCrumb({
    required this.name,
    required this.isActive,
  }) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? ' >' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get item => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {}
}

class BreadCrumbHomePage extends StatefulWidget {
  const BreadCrumbHomePage({Key? key}) : super(key: key);

  @override
  State<BreadCrumbHomePage> createState() => _BreadCrumbHomePageState();
}

class _BreadCrumbHomePageState extends State<BreadCrumbHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BreadCrumb'),
      ),
    );
  }
}
