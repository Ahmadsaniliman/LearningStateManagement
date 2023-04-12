import 'package:flutter/foundation.dart';

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({
    required this.token,
  });

  const LoginHandle.fooBar() : token = 'foobar';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  String toString() => ' LoginHandle (token  == $token)';

  @override
  int get hashCode => token.hashCode;
}

enum LoginError {
inValidLogin }