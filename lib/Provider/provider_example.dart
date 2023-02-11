import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BreadCrumb {
  final String name;
  bool isActive;
  final String id;

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

  String get title => name + (isActive ? ' >' : '');
//   String get title => isActive ? '$name + >' : '';
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get item => UnmodifiableListView(_items);

  void addBreadCrumb(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.isActive;
    }

    _items.add(breadCrumb);
    notifyListeners();
  }

  void clearBreadCrumb() {
    _items.clear();
  }
}

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> breadCrumb;
  const BreadCrumbWidget({
    Key? key,
    required this.breadCrumb,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: breadCrumb.map((breadCrumb) {
        return Text(
          breadCrumb.title,
          style: TextStyle(
            color: breadCrumb.isActive ? Colors.blue : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

class BreadCrumbHomePage extends StatelessWidget {
  const BreadCrumbHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<BreadCrumbProvider>(
            builder: (context, value, child) {
              return BreadCrumbWidget(
                breadCrumb: value.item,
              );
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/new-Route');
            },
            child: const Text('Add new bread crumb'),
          ),
          TextButton(
            onPressed: () {
              context.read<BreadCrumbProvider>().clearBreadCrumb();
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Eneter a new bread crumb here ...',
            ),
          ),
          TextButton(
            onPressed: () {
              final text = _controller.text;
              final breadCrumb = BreadCrumb(
                name: text,
                isActive: false,
              );
              context.read<BreadCrumbProvider>().addBreadCrumb(
                    breadCrumb,
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
