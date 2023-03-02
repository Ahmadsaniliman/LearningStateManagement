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

  @override
  bool operator ==(covariant BaseObject other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CheapObject extends BaseObjectProvider {}

class ExpensiveObject extends BaseObjectProvider {}

class BaseObjectProvider extends ChangeNotifier {
  late String id;
  late String lastUpdated;
  late CheapObject _cheapObject;
  late ExpensiveObject _expensiveObject;
  late StreamSubscription _cheapStreamSub;
  late StreamSubscription _expensiveStreamSub;

  CheapObject get cheapObject => _cheapObject;
  ExpensiveObject get expensiveObject => _expensiveObject;

  void start() {
    _cheapStreamSub = Stream.periodic(const Duration(seconds: 2)).listen(
      (event) {
        _cheapObject = CheapObject();
        notifyListeners();
      },
    );
    _expensiveStreamSub = Stream.periodic(const Duration(seconds: 2)).listen(
      (event) {
        _expensiveObject = ExpensiveObject();
        notifyListeners();
      },
    );
  }

  void stop() {
    _cheapStreamSub.cancel();
    _expensiveStreamSub.cancel();
  }

  @override
  void notifyListeners() {
    id = const Uuid().v4();
    super.notifyListeners();
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
      width: double.infinity,
      child: Column(
        children: [
          const Text('CheapObject'),
          const Text('LastUpdated'),
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
    final provider = context.select<BaseObjectProvider, ExpensiveObject>(
      (provider) => provider.expensiveObject,
    );
    return Container(
      height: 100.0,
      width: double.infinity,
      color: Colors.blue,
      child: Column(
        children: [
          const Text('Id'),
          const Text('Last Updated'),
          Text(provider.lastUpdated),
        ],
      ),
    );
  }
}

class BaseObjectWidget extends StatelessWidget {
  const BaseObjectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BaseObjectProvider>();
    return Container(
      height: 100.0,
      width: double.infinity,
      color: Colors.lightGreen,
      child: Column(
        children: [
          const Text('BaseObject Widget'),
          const Text('Last Updated'),
          Text(provider.lastUpdated),
        ],
      ),
    );
  }
}

class BaseObjectWidgetHome extends StatelessWidget {
  const BaseObjectWidgetHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Row(
            children: const [
              Expanded(
                child: CheapWidget(),
              ),
              Expanded(
                child: ExpensiveWidget(),
              ),
            ],
          ),
          const Expanded(
            child: BaseObjectWidget(),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<BaseObjectProvider>().start();
                },
                child: const Text('Start'),
              ),
              TextButton(
                onPressed: () {
                  context.read<BaseObjectProvider>().stop();
                },
                child: const Text('Stop'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
