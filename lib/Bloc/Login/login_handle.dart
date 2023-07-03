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


enum LoginErrors {
    inValidHandle
}

const longinError = '';