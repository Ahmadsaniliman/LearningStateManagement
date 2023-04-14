import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement_/Bloc/Login/app_action.dart';
import 'package:state_mangement_/Bloc/Login/login_api.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';
import 'package:state_mangement_/Bloc/Login/notes_api.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginError? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState({
    required this.isLoading,
    required this.loginError,
    required this.loginHandle,
    required this.fetchedNotes,
  });

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;
}

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NoteApiProtocol notesApi;
  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>((event, emit) async {
      // Started Loading.
      emit(
        const AppState(
          isLoading: true,
          loginError: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      // log the user in.
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );
      // emit.
      emit(
        AppState(
          isLoading: false,
          loginError: loginHandle == null ? LoginError.inValidLogin : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>((event, emit) async {
      emit(
        AppState(
          isLoading: false,
          loginError: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.fooBar()) {
        emit(
          AppState(
            isLoading: false,
            loginError: LoginError.inValidLogin,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      } else {
        final notes = await notesApi.getNotes(
          loginHandle: loginHandle!,
        );
        emit(
          AppState(
              isLoading: false,
              loginError: null,
              loginHandle: loginHandle,
              fetchedNotes: notes),
        );
      }
    });
  }
}
