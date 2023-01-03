import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BreadCrumb {
  final String uuid;
  final String name;
  bool isActive;

  BreadCrumb({
    required this.isActive,
    required this.name,
  }) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  String get title => isActive ? '#name > ' : '';
  // OR
//   String get title => name + (isActive ? '> ' : '');
}

class BreadCrumbNotifier extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get item => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
  }
}
