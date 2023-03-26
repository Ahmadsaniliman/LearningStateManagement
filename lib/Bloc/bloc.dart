import 'package:flutter/material.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

enum PersonUrl { person1, person2 }

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

  const LoadPersonAction({required this.url}) : super();
}
