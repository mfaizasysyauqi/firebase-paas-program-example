import 'package:firebase_paas_program_example/domain/aplication/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteInput extends ConsumerStatefulWidget {
  const NoteInput({super.key});

  @override
  ConsumerState<NoteInput> createState() => _NoteInputState();
}

class _NoteInputState extends ConsumerState<NoteInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_controller.text.isEmpty) return;

    final editingId = ref.read(editingNoteIdProvider);
    if (editingId != null) {
      ref.read(notesRepositoryProvider).updateNote(editingId, _controller.text);
      ref.read(editingNoteIdProvider.notifier).state = null;
    } else {
      ref.read(notesRepositoryProvider).addNote(_controller.text);
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(editingNoteIdProvider, (previous, next) {
      if (next != null) {
        final notes = ref.read(notesStreamProvider).value;
        final noteToEdit = notes?.firstWhere((note) => note.id == next);
        if (noteToEdit != null) {
          _controller.text = noteToEdit.content;
        }
      }
    });

    final editingId = ref.watch(editingNoteIdProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: editingId != null ? 'Edit Note' : 'New Note',
              border: const OutlineInputBorder(),
              suffixIcon: editingId != null
                  ? IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        ref.read(editingNoteIdProvider.notifier).state = null;
                        _controller.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _saveNote,
            child: Text(editingId != null ? 'Update Note' : 'Add Note'),
          ),
        ],
      ),
    );
  }
}
