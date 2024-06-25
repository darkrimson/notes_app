import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/providers/note_provider.dart';

class NoteDetailPage extends StatelessWidget {
  const NoteDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Note? note = ModalRoute.of(context)!.settings.arguments as Note?;
    final titleController = TextEditingController(text: note?.title ?? '');
    final contentController = TextEditingController(text: note?.content ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<NoteProvider>(context, listen: false)
                    .deleteNote(note);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 10,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final content = contentController.text;

                if (title.isEmpty || content.isEmpty) {
                  return;
                }

                final noteProvider =
                    Provider.of<NoteProvider>(context, listen: false);

                if (note == null) {
                  final newNote = Note(
                    title: title,
                    content: content,
                    createdAt: DateTime.now().toString(),
                  );
                  noteProvider.addNote(newNote);
                } else {
                  note.title = title;
                  note.content = content;
                  noteProvider.updateNote(note);
                }

                Navigator.pop(context);
              },
              child: Text(note == null ? 'Add Note' : 'Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
