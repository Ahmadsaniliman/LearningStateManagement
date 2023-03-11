import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PersonUrl { person1, person2 }

@immutable
abstract class LoadAction {
  const LoadAction();
}

abstract class PersonLoadAction implements LoadAction {
  final PersonUrl url;
  final String name;
  final int age;

  PersonLoadAction({
    required this.name,
    required this.age,
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

extension GetPersonJson on PersonUrl {
  String get personUrl {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/api/person1.json';

      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/api/person2.json';
    }
  }
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCach;

  const FetchResult({
    required this.persons,
    required this.isRetrivedFromCach,
  });

  @override
  String toString() =>
      'FetchedResult = (isretrivedFromCahc = $isRetrivedFromCach, person = $persons,)';
}

Future<Iterable<Person>> getString(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((request) => request.close())
    .then((response) => response.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cach = {};
  PersonBloc() : super(null);
}

class BlocHomePage extends StatelessWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Hme Page'),
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
