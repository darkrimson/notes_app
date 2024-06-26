import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/note_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notes $formattedDate'),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteNote(note);
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/note_detail', arguments: note);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/note_detail'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
