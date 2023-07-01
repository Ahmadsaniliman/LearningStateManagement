import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
class BaseObject {
  final String id;
  final String lastUpdated;

  BaseObject()
      : id = const Uuid().v4(),
        lastUpdated = DateTime.now().toIso8601String();

  @override
  bool operator ==(covariant BaseObject other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@immutable
class CheapObject extends BaseObject {}

@immutable
class ExpensiveObject extends BaseObject {}

class ObjectProvider extends ChangeNotifier {
  late String id;
  late CheapObject _cheapObject;
  late StreamSubscription _cheapObjectSubs;
  late ExpensiveObject _expensiveObject;
  late StreamSubscription _expensiveObjectSubs;

  CheapObject get cheapObject => _cheapObject;
  ExpensiveObject get expensiveObject => _expensiveObject;

  void start() {
    _cheapObjectSubs = Stream.periodic(
      const Duration(seconds: 1),
    ).listen((event) {
      _cheapObject = CheapObject();
      notifyListeners();
    });

    _expensiveObjectSubs = Stream.periodic(
      const Duration(seconds: 10),
    ).listen((event) {
      _expensiveObject = ExpensiveObject();
      notifyListeners();
    });
  }

  void stop() {
    _cheapObjectSubs.cancel();
    _expensiveObjectSubs.cancel();
  }

  ObjectProvider()
      : id = const Uuid().v4(),
        _cheapObject = CheapObject(),
        _expensiveObject = ExpensiveObject();

  @override
  void notifyListeners() {
    id = const Uuid().v4();
    super.notifyListeners();
  }
}
