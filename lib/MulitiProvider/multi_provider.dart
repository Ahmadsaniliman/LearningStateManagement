import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String now() => DateTime.now().toIso8601String();

@immutable
class Minutes {
  final String value;
  Minutes() : value = now();
}

@immutable
class Seconds {
  final String value;
  Seconds() : value = now();
}

Stream<String> newStream(Duration duration) => Stream.periodic(
      duration,
      (_) => now(),
    );

class MultProviderMinutes extends StatelessWidget {
  const MultProviderMinutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Expanded(
      child: Container(
        color: Colors.green,
        child: Text(minutes.value),
      ),
    );
  }
}

class MultProviderSeconds extends StatelessWidget {
  const MultProviderSeconds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Expanded(
      child: Container(
        color: Colors.blue,
        child: Text(seconds.value),
      ),
    );
  }
}

class MultiProvider extends StatelessWidget {
  const MultiProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const MultiProvider(),
    );
  }
}

class MultiP extends StatelessWidget {
  const MultiP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ManUnited extends StatefulWidget {
  const ManUnited({Key? key}) : super(key: key);

  @override
  State<ManUnited> createState() => _ManUnitedState();
}

class _ManUnitedState extends State<ManUnited> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
