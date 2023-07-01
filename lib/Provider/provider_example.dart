import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BreadCrumb {
  final String name;
  bool isActive;
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
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get item => UnmodifiableListView(_items);

  void addBreadCrumb(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate;
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
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
        title: const Text('BreadCrumb Home'),
      ),
      body: Column(
        children: [
          Consumer<BreadCrumbProvider>(builder: (
            context,
            value,
            child,
          ) {
            return BreadCrumbWidget(
              breadCrumb: value.item,
            );
          }),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/new-Route");
            },
            child: const Text('Add BredaCrumb'),
          ),
          TextButton(
            onPressed: () {
              context.read<BreadCrumbProvider>().reset();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class BreadCrumbWidget extends StatelessWidget {
  const BreadCrumbWidget({Key? key, required this.breadCrumb})
      : super(key: key);

  final UnmodifiableListView<BreadCrumb> breadCrumb;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumb
          .map(
            (breadCrumb) => Text(
              breadCrumb.name,
              style: TextStyle(
                color: breadCrumb.isActive ? Colors.blue : Colors.black,
              ),
            ),
          )
          .toList(),
    );
  }
}

class BreadCrumbRoute extends StatefulWidget {
  const BreadCrumbRoute({Key? key}) : super(key: key);

  @override
  State<BreadCrumbRoute> createState() => _BreadCrumbRouteState();
}

class _BreadCrumbRouteState extends State<BreadCrumbRoute> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add BreadCrumb'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text;
              if (text.isNotEmpty) {
                final breadCrumb = BreadCrumb(name: text, isActive: false);
                context.read<BreadCrumbProvider>().addBreadCrumb(breadCrumb);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
