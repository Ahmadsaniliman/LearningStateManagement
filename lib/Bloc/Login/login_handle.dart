import 'package:flutter/material.dart';

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({
    required this.token,
  });

  const LoginHandle.fooBar() : token = 'foo@bar.com';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle (token = $token)';
}

enum LoginErrors { inValidLogins}

const emailOrPasswordEmptyDialog =
    'Please fill in both email and password fields';
const emailOrPasswordDescription =
    'You seem to have fogotten email or password field please fill them both';
const loginErrorDialogTitle = 'Login error';
const loginErrorDialogContent =
    'Invalid email/password combination, please try again with valid login crendential';
const pleaseWait = 'Please wait';
const enterYourPasswordHere = 'Enter your password here...';
const enterYourEmailHere = 'Enter your email here...';
const ok = 'ok';
const login = 'login';
const homePage = 'homePage';
