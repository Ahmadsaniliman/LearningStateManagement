import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Container(
      height: 100.0,
      color: Colors.green,
      child: Text(minutes.value),
    );
  }
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Container(
      height: 100.0,
      color: Colors.blue,
      child: Text(seconds.value),
    );
  }
}

class MuiltiProviderWidget extends StatelessWidget {
  const MuiltiProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      //   body : MuiltiProviderWidget(provid),
    );
  }
}
