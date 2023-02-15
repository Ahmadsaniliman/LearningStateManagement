import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/new-Route");
            },
            child: const Text('Add BreadCrumb'),
          ),
          TextButton(
            onPressed: () {
              context.read<BreadCrumbProvider>().resetBreadCrumb();
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class NewBreadCrumbPage extends StatefulWidget {
  const NewBreadCrumbPage({Key? key}) : super(key: key);

  @override
  State<NewBreadCrumbPage> createState() => _NewBreadCrumbPageState();
}

class _NewBreadCrumbPageState extends State<NewBreadCrumbPage> {
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
        title: const Text('Add Bread Crumb'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text;
              if (text.isNotEmpty) {
                final breadCrumb = BreadCrumb(
                  name: text,
                  isActive: false,
                );
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
