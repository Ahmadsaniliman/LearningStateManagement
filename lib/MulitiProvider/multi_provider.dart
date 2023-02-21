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
