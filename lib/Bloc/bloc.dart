import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const names = [
  'Muhammad',
  'Ahmad',
  'Sani',
  'Liman',
];

class Person {
  final String name;
  final String age;

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as String;
}

enum PersonUrl { person1, person2 }

extension GetRandomPersonUrl on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/api/person1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/api/person2.json';
    }
  }
}

extension SubScrpit<T> on Iterable<T> {
  T? operator [](int index) => index > length ? elementAt(index) : null;
}

class LoadAction {
  const LoadAction();
}

class PersonLoadAction implements LoadAction {
  final PersonUrl url;

  PersonLoadAction({
    required this.url,
  }) : super();
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((res) => res.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

class FetchedResult {
  final Iterable<Person> persons;
  final bool isRetrvedFromCache;

  FetchedResult({
    required this.persons,
    required this.isRetrvedFromCache,
  });
}

class PersonBloc extends Bloc<LoadAction, FetchedResult?> {
     final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
     on<PersonLoadAction>((event, emit) {
          final url = event.url;
          if (_cache.containsKey(url)) {
               final cachePerson = _cache[url]; 
               final result = FetchedResult(persons: cachePerson, isRetrvedFromCache: true,);
          } else {}
     });
  };
}

class BlocHomePage extends StatelessWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
