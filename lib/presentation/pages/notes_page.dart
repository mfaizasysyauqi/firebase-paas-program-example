import 'package:firebase_paas_program_example/domain/aplication/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/note_list.dart';
import '../widgets/note_input.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingId = ref.watch(editingNoteIdProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(editingId != null ? 'Edit Note' : 'Firebase Notes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          NoteInput(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Color.fromARGB(50, 158, 158, 158),
              thickness: 1,
            ),
          ),
          Expanded(child: NoteList()),
        ],
      ),
    );
  }
}
