import 'dart:convert';

import 'package:flutter/material.dart';

enum PersonUrl { person1, person2 }

@immutable
abstract class LoadAction {
  const LoadAction();
}

extension StringUrl on PersonUrl {
  String get getUrl {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/api/person1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/api/person2.json';
    }
  }
}

@immutable
abstract class LoadPersonAction implements LoadAction {
  final PersonUrl url;

  const LoadPersonAction({
    required this.url,
  }) : super();
}

class Person {
  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}

class BlocHomePage extends StatelessWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
