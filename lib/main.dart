import 'package:flutter/material.dart';
import 'package:state_mangement_/Inherit/inherit.dart';
import 'package:state_mangement_/ValueNot/value_not.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'State Management Demo',
        theme: ThemeData(),
        home: ApiProvider(
          api: Api(),
          child: const MyHomePage(),
        ),
        routes: {
          "/new-Contact-Route": (context) => const NewContactPage(),
        });
  }
}
