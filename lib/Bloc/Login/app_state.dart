import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement_/Bloc/Login/app_action.dart';
import 'package:state_mangement_/Bloc/Login/login_api.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';
import 'package:state_mangement_/Bloc/Login/notes_api.dart';

@immutable
class AppState {
  final bool isLoadding;
  final LoginHandle? loginHandle;
  final LoginErrors? loginErrors;
  final Iterable<Note>? fetechedNotes;

  const AppState({
    required this.isLoadding,
    required this.loginHandle,
    required this.loginErrors,
    required this.fetechedNotes,
  });

  const AppState.empty()
      : isLoadding = false,
        loginErrors = null,
        loginHandle = null,
        fetechedNotes = null;
  @override
  String toString() => {
        'isLoadding': isLoadding,
        'loginHandle': loginHandle,
        'loginErrors': loginErrors,
        'fetechedNotes': fetechedNotes,
      }.toString();
}

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) ;
}
