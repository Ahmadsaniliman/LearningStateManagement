import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_mangement_/Bloc/Login/app_action.dart';
import 'package:state_mangement_/Bloc/Login/app_state.dart';
import 'package:state_mangement_/Bloc/Login/login_api.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';
import 'package:state_mangement_/Bloc/Login/notes_api.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoginAction>((event, emit) async {
      emit(
        const AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: null,
          fetchedNotes: null,
        ),
      );

      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );

      emit(
        AppState(
          isLoading: false,
          loginErrors: loginHandle == null ? LoginErrors.inValidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
        ),
      );
    });

    on<LoadNotesAction>((event, emit) async {
      emit(
        AppState(
          isLoading: true,
          loginErrors: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
        ),
      );
    });
  }
}
