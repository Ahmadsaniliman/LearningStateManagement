import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const emaolOrPasswordEmptyDialogTitle =
    'Please fill in both email and password fields';
const emaolOrPasswordEmptyDescription =
    'You seem to have forgotten to enter the email or password field or both. Please';
const loginErrorLoginTitle = 'Login Error';
const loginErrorDialogContent =
    'Invalid emial/password combination. Please try again with valid login credentials';
const pleaseWait = 'Please wait ...';
const enterYourPasswordHere = 'Enter your password here';
const enterYourEmailHere = 'Enter your email here';
const ok = 'OK';

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
  int get hashCode => token.hashCode;

  @override
  String toString() => 'LoginHandle (token == $token)';
}

enum LoginErrors { invalidHandle }

@immutable
class Note {
  final String title;

  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note (title : $title)';
}

final mockedNote = Iterable.generate(
  3,
  (i) => Note(title: '${i + 1}'),
);

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
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
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () =>
            email == 'muhammadahmadsaniliman' &&
            password == 'muhammadahmadsaniliman',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
      );
}

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginHandle == const LoginHandle.fooBar() ? mockedNote : null,
      );
}

@immutable
abstract class AppAction {
  const AppAction();
}

@immutable
class LoginAction implements AppAction {
  final String email;
  final String password;

  const LoginAction({
    required this.email,
    required this.password,
  });
}

@immutable
class NotesAction implements AppAction {
  const NotesAction();
}

@immutable
class AppState {
  final bool isLodding;
  final LoginErrors? loginErrors;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState({
    required this.loginErrors,
    required this.loginHandle,
    required this.fetchedNotes,
    required this.isLodding,
  });

  const AppState.empty()
      : isLodding = false,
        loginErrors = null,
        loginHandle = null,
        fetchedNotes = null;

  @override
  String toString() => {
        'isLodding': isLodding,
        'loginErrors': loginErrors,
        'loginHandle': loginHandle,
        'fetchedNotes': fetchedNotes,
      }.toString();
}

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol noteApi;

  AppBloc({
    required this.loginApi,
    required this.noteApi,
  }) : super(
          const AppState.empty(),
        ) {
    on<LoginAction>((event, emit) async {
      emit(const AppState(
        isLodding: true,
        loginErrors: null,
        loginHandle: null,
        fetchedNotes: null,
      ));

      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );

      emit(
        AppState(
          loginErrors: loginHandle == null ? LoginErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchedNotes: null,
          isLodding: false,
        ),
      );
    });

    on<NotesAction>((event, emit) async {
      emit(
        AppState(
          loginErrors: null,
          loginHandle: state.loginHandle,
          fetchedNotes: null,
          isLodding: true,
        ),
      );

      final loginHandle = state.loginHandle;
      if (loginHandle != const LoginHandle.fooBar()) {
        emit(
          AppState(
              loginErrors: LoginErrors.invalidHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
              isLodding: false),
        );
        return;
      }
      final notes = await noteApi.getNotes(loginHandle: loginHandle!);
      emit(
        AppState(
          loginErrors: null,
          loginHandle: loginHandle,
          fetchedNotes: notes,
          isLodding: false,
        ),
      );
    });
  }
}

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialogFialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  final options = optionBuilder();
  return showDialog<T?>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: options.keys.map((optionTitle) {
        final value = options[optionTitle];
        return TextButton(
          onPressed: () {
            if (value != null) {
              Navigator.of(context).pop(value);
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(optionTitle),
        );
      }).toList(),
    ),
  );
}
