import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';

class FirebaseNotesRepository implements NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Note>> getNotes() {
    return _firestore
        .collection('notes')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note(
                  id: doc.id,
                  content: doc['content'],
                  timestamp: (doc['timestamp'] as Timestamp?)?.toDate(),
                ))
            .toList());
  }

  @override
  Future<void> addNote(String content) async {
    await _firestore.collection('notes').add({
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> updateNote(String id, String content) async {
    await _firestore.collection('notes').doc(id).update({
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteNote(String id) async {
    await _firestore.collection('notes').doc(id).delete();
  }
}
