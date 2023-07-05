import 'package:flutter/material.dart';

@immutable
class Loginhandle {
  final String token;

  const Loginhandle({
    required this.token,
  });

  const Loginhandle.fooBar() : token = 'foobar';

  @override
  bool operator ==(covariant Loginhandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle (token = $token)';
}

enum LoginErrors { inValidHandle }

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
