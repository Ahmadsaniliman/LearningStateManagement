import 'package:flutter/foundation.dart';

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({
    required this.token,
  });

  const LoginHandle.fooBar() : token = 'fooBar';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  int get hashCode => token.hashCode;

  @override
  String toString() => ' LoginHandle (Token = $token)';
}

enum LoginErrors { invalidHandle }