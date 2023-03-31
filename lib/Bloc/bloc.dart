import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final persons = [
  'Muhammad',
  'Ahmad',
  'Sani',
  'Liman',
];

enum PersonUrl { person1, person2 }

extension GetRandomName on PersonUrl {
  String get getUrl {
    switch (this) {
      case PersonUrl.person1:
        return 'http://127.0.0.1:5500/lib/api/person1.json';
      case PersonUrl.person2:
        return 'http://127.0.0.1:5500/lib/api/person2.json';
    }
  }
}

extension SubScript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class PersonLoadAction implements LoadAction {
  final PersonUrl url;
  const PersonLoadAction({
    required this.url,
  });
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((res) => res.close())
    .then((req) => req.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJsom(e)));

class Person {
  final String name;
  final String age;

  Person.fromJsom(Map<String, String> json)
      : name = json['name'] as String,
        age = json['age'] as String;
}

@immutable
class FetchedResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCache;

  const FetchedResult({
    required this.persons,
    required this.isRetrivedFromCache,
  });

  @override
  String toString() =>
      'FetchedResult (isRetrivedFromCache =  $isRetrivedFromCache, person = $persons)';
}

class PersonBloc extends Bloc<LoadAction, FetchedResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<PersonLoadAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final cachedPerons = _cache[url]!;
        final result = FetchedResult(
          persons: cachedPerons,
          isRetrivedFromCache: true,
        );
        emit(result);
      } else {
        final persons = await getPersons(url.getUrl);
        _cache[url] = persons;
        final result = FetchedResult(
          persons: persons,
          isRetrivedFromCache: false,
        );
        emit(result);
      }
    });
  }
}

class BlocHomePage extends StatelessWidget {
  const BlocHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(
                        const PersonLoadAction(url: PersonUrl.person1),
                      );
                },
                child: const Text('Load Json#1'),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonBloc>().add(
                        const PersonLoadAction(url: PersonUrl.person2),
                      );
                },
                child: const Text('Load Json#2'),
              ),
            ],
          ),
          BlocBuilder<PersonBloc, FetchedResult?>(
            buildWhen: (previousResult, currentResult) =>
                previousResult?.persons != currentResult?.persons,
            builder: (context, state) => Expanded(
              child: ListView.builder(
                itemCount: persons.length,
                itemBuilder: (context, index) {
                  final person = persons[index];
                  return ListTile(
                    title: Text(person),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
