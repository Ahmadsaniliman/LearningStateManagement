import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';
import 'package:state_mangement_/Bloc/Login/notes_api.dart';

@immutable
class AppState {
  final bool isLodding;
  final LoginErrors? loginErrors;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState({
    required this.isLodding,
    required this.loginErrors,
    required this.loginHandle,
    required this.fetchedNotes,
  });

  @override
  String toString() => {
        'isLoading': isLodding,
        'loginErrors': loginErrors,
        'loginHandle': loginHandle,
        'fetchedNotes': fetchedNotes,
      }.toString();

  const AppState.empty()
      : isLodding = false,
        loginErrors = null,
        loginHandle = null,
        fetchedNotes = null;
}
