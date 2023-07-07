import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> loginIn({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  const LoginApi._sharedInstance();
  static const LoginApi _shared = LoginApi._sharedInstance();
  factory LoginApi.instance() => _shared;
  @override
  Future<LoginHandle?> loginIn({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 4),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
      );
}
