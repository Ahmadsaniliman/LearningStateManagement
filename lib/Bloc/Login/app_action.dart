import 'package:flutter/foundation.dart';

@immutable
class AppAction {}

@immutable
class LoginAction implements AppAction {
  final String email;
  final String password;

  const LoginAction({
    required this.email,
    required this.password,
  });
}

@immutable
class LoadNotesAction {
  const LoadNotesAction();
}
