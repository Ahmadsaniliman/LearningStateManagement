import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

enum PersonUrl { person1, person2 }

@immutable
abstract class LoadAction {
  const LoadAction();
}

extension GetRandomNames on PersonUrl {
  String get getPersonUrl {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/api/person1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/api/person2.json';
    }
  }
}

Future<Iterable<Person>> getPerson(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((request) => request.close())
    .then((response) => response.transform(utf8.decoder).join())
    .then((string) => json.encode(string) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

abstract class PersonLoadAction implements LoadAction {
  final PersonUrl url;

  PersonLoadAction({
    required this.url,
  });
}

class Person {
  final String name;
  final int age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;
}
