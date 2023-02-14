import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BreadCrumb {
  final String name;
  final String id;
  bool isActive;

  BreadCrumb({
    required this.name,
    required this.isActive,
  }) : id = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
  String get title => name + (isActive ? ' > ' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView get item => UnmodifiableListView(_items);

  void addBreadCrumb(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.isActive;
    }
    _items.add(breadCrumb);
  }

  void resetBreadCrumb() {
    _items.clear();
  }
}

class BreadCrumbWidget extends StatelessWidget {
  const BreadCrumbWidget({
    Key? key,
    required this.breadCrumbs,
  }) : super(key: key);

  final UnmodifiableListView<BreadCrumb> breadCrumbs;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumbs
          .map(
            (breadCrumb) => Text(
              breadCrumb.title,
              style: TextStyle(
                color: breadCrumb.isActive ? Colors.blue : Colors.black,
              ),
            ),
          )
          .toList(),
    );
  }
}

class BreadCrumbHomePAge extends StatelessWidget {
  const BreadCrumbHomePAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add BreadCrumb'),
      ),
    );
  }
}
