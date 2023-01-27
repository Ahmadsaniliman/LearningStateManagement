import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Api {
  String? dateAndTime;

  Future<String> getCurrentTime() => Future.delayed(
        const Duration(seconds: 2),
        () => DateTime.now().toIso8601String(),
      ).then(
        (value) => dateAndTime = value,
      );
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

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class DtaAndTimeWidget extends StatelessWidget {
  const DtaAndTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(
      api.dateAndTime ?? 'Tap on the screen',
    );
  }
}

class InheritedHomePage extends StatelessWidget {
  const InheritedHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tap on The Screen'),
      ),
      body: GestureDetector(
        onTap: () {},
        child: const SizedBox(
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
