import 'package:flutter/foundation.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';

@immutable
class Note {
  final String title;

  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note (Note == $title)';
}

final mockedNote = Iterable.generate(
  3,
  (i) => Note(title: 'Note ${i + 1}'),
);

@immutable
abstract class NoteApiProtocol {
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  });
}

@immutable
class NotesApi implements NoteApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => loginHandle == const LoginHandle.fooBar() ? mockedNote : null,
      );
}
