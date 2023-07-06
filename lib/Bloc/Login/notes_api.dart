import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';

@immutable
class Note {
  final String title;

  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note (title = $title)';
}

final mockNotes = Iterable.generate(
  3,
  (i) => Note(
    title: 'Note ${i + 1}',
  ),
);

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Note>?> getNotes({
    required Loginhandle loginHandle,
  });
}

@immutable
class NotesApi extends NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({
    required Loginhandle loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 5),
        () => loginHandle == const Loginhandle.fooBar() ? mockNotes : null,
      );
}
