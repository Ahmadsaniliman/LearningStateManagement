import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BaseObject {
  final String id;
  final String lastUpdated;

  BaseObject()
      : id = const Uuid().v4(),
        lastUpdated = DateTime.now().toIso8601String();
}

@immutable
class CheapObject extends BaseObject {}

@immutable
class ExpensiveObject extends BaseObject {}

class BaseObjectProvider extends ChangeNotifier {
  late final String id;
  late final CheapObject _cheapObject;
  late final StreamSubscription _cheapObjectSubs;

  late final ExpensiveObject _expensiveObject;
  late final StreamSubscription _expensiveObjectSubs;

  CheapObject get cheapObject => _cheapObject;
  ExpensiveObject get expensiveObject => _expensiveObject;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
