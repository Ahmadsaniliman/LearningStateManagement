import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';

@immutable
class Note {
  final String title;
  const Note({
    required this.title,
  });

  @override
  String toString() => 'Note (Title = $title)';
}

final mockNotes = Iterable.generate(
  3,
  (i) => Note(title: 'Note ${i + 1}'),
);

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> fetchedNotes({
    required LoginHandle? loginHandle,
  });
}

@immutable
class NotesApi implements NotesApiProtocol {
  const NotesApi._sharedInstance();
  static const NotesApi _shared = NotesApi._sharedInstance();
  factory NotesApi() => _shared;

  @override
  Future<Iterable<Note>?> fetchedNotes({
    required LoginHandle? loginHandle,
  }) =>
      Future.delayed(
        const Duration(seconds: 4),
        () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null,
      );
}
