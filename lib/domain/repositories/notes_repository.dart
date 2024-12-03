import '../entities/note.dart';

abstract class NotesRepository {
  Stream<List<Note>> getNotes();
  Future<void> addNote(String content);
  Future<void> updateNote(String id, String content);
  Future<void> deleteNote(String id);
}