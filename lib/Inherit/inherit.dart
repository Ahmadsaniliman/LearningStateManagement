import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Api {
  String? dateAndTime;

  Future<String> getTimeAndDate() {
    return Future.delayed(
            const Duration(seconds: 4), () => DateTime.now().toIso8601String())
        .then((value) {
      dateAndTime = value;
      return value;
    });
  }
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String id;

  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : id = const Uuid().v4(),
        super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return id != oldWidget.id;
  }
}

class HomepagetimeAndDate extends StatelessWidget {
  const HomepagetimeAndDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
