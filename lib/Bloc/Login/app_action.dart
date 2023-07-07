import 'package:flutter/material.dart';

@immutable
class AppAction {
  const AppAction();
}

@immutable
class LoginAcion implements AppAction {
  final String email;
  final String password;

  const LoginAcion({
    required this.email,
    required this.password,
  });
}

@immutable
class LoadNotesAction implements AppAction {
  const LoadNotesAction();
}
