import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<Loginhandle?> login({
    required String email,
    required password,
  });
}

@immutable
class LoginApi extends LoginApiProtocol {
  const LoginApi._sharedInstance();
  static const _shared = LoginApi._sharedInstance();
  factory LoginApi() => _shared;

  @override
  Future<Loginhandle?> login({
    required String email,
    required password,
  }) =>
      Future.delayed(
        const Duration(seconds: 4),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then(
        (isLoggedIn) => isLoggedIn ? const Loginhandle.fooBar() : null,
      );
}
