import 'package:flutter/material.dart';
import 'package:state_mangement_/SliderChange/slider_change.dart';
import 'package:state_mangement_/ValueNot/value_not.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management Demo',
      theme: ThemeData(),
      home: const SliderHomePage(),
      routes: {
        "/new-Contact-Route": (context) => const NewContactPage(),
      },
    );
  }
}
