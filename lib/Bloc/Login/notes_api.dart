import 'package:flutter/material.dart';
import 'package:state_mangement_/Bloc/Login/login_handle.dart';

@immutable
class Notes {
  final String title;

  const Notes({
    required this.title,
  });

  @override
  String toString() => 'Note (title = $title)';
}

final mockNotes = Iterable.generate(
  3,
  (i) => Notes(title: 'Note ${i + 1}'),
);

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();

  Future<Iterable<Notes?>> getNotes({
    required Loginhandle loginHandle,
  });
}
