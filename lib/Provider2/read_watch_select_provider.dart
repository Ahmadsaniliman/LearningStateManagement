import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BaseObject {
  final String id;
  final String lastUpdated;

  BaseObject()
      : id = const Uuid().v4(),
        lastUpdated = DateTime.now().toIso8601String();
}

class CheapObject extends BaseObject {}

class ExpensiveObject extends BaseObject {}

class BaseObjectProvider extends ChangeNotifier {
  late final String id;
  late final CheapObject _cheapObject;
  late final ExpensiveObject _expensiveObject;
  late final StreamSubscription _cheapStreamSub;
  late final StreamSubscription _expensiveStreamSub;

  CheapObject get cheapObject => _cheapObject;
  ExpensiveObject get expensiveObject => _expensiveObject;

  BaseObjectProvider()
      : id = const Uuid().v4(),
        _cheapObject = CheapObject(),
        _expensiveObject = ExpensiveObject();

  void start() {
    _cheapStreamSub = Stream.periodic(const Duration(seconds: 1)).listen((_) {
      _cheapObject = CheapObject();
      notifyListeners();
    });
    _expensiveStreamSub =
        Stream.periodic(const Duration(seconds: 1)).listen((_) {
      _expensiveObject = ExpensiveObject();
      notifyListeners();
    });
  }

  void stop() {
    _cheapStreamSub.cancel();
    _expensiveStreamSub.cancel();
  }

  @override
  void notifyListeners() {
    id = const Uuid().v4();
    notifyListeners();
  }
}

class CheapWidget extends StatelessWidget {
  const CheapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cheapObject = context.select<BaseObjectProvider, CheapObject>(
      (provider) => provider.cheapObject,
    );
    return Container(
      height: 100.0,
      color: Colors.green,
      child: Column(
        children: [
          const Text('CheapObject'),
          const Text('Last Updated'),
          Text(cheapObject.lastUpdated),
        ],
      ),
    );
  }
}

class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expensiveObject = context.select<BaseObjectProvider, ExpensiveObject>(
        (provider) => provider.expensiveObject);
    return Container(
      height: 100.0,
      color: Colors.blue,
      child: Column(
        children: [
          const Text('ExpensiveObject'),
          const Text('Last Updated'),
          Text(expensiveObject.lastUpdated),
        ],
      ),
    );
  }
}
