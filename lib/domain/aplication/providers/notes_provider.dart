import 'package:firebase_paas_program_example/domain/entities/note.dart';
import 'package:firebase_paas_program_example/domain/repositories/firebase_notes_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final notesRepositoryProvider = Provider((ref) => FirebaseNotesRepository());

final notesStreamProvider = StreamProvider<List<Note>>((ref) {
  return ref.watch(notesRepositoryProvider).getNotes();
});

final editingNoteIdProvider = StateProvider<String?>((ref) => null);
