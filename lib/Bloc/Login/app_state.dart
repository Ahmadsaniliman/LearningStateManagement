import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';
import 'package:state_mangement_/Bloc/Login/notes_api.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginErrors;
  final Loginhandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState.empty()
      : isLoading = false,
        loginErrors = null,
        loginHandle = null,
        fetchedNotes = null;

  const AppState({
    required this.isLoading,
    required this.loginErrors,
    required this.loginHandle,
    required this.fetchedNotes,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginErros': loginErrors,
        'loginHandle': loginHandle,
        'FetchedNotes': fetchedNotes,
      }.toString();
}
