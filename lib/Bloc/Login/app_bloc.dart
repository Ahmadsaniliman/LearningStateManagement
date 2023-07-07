import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement_/Bloc/Login/app_action.dart';
import 'package:state_mangement_/Bloc/Login/app_state.dart';
import 'package:state_mangement_/Bloc/Login/login_api.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';
import 'package:state_mangement_/Bloc/Login/notes_api.dart';

@immutable
class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoginAcion>((event, emit) async {
      emit(
        const AppState(
          isLodding: true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );
      final loginHandle = await loginApi.loginIn(
        email: event.email,
        password: event.password,
      );

      emit(
        AppState(
          isLodding: false,
          loginErrors: loginHandle == null ? LoginErrors.inValidLogins : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>(
      (event, emit) async {
        emit(
          AppState(
            isLodding: true,
            loginErrors: null,
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );

        final loginHandle = state.loginHandle;
        if (loginHandle != const LoginHandle.fooBar()) {
          emit(
            AppState(
              isLodding: false,
              loginErrors: LoginErrors.inValidLogins,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
          return;
        } else {
          final notes = await notesApi.fetchedNotes(
            loginHandle: loginHandle,
          );
          emit(
            AppState(
              isLodding: false,
              loginErrors: null,
              loginHandle: loginHandle,
              fetchedNotes: notes,
            ),
          );
        }
      },
    );
  }
}
