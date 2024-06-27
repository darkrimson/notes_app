import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/pages/note_detail_page.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';
import 'pages/calendar_page.dart';
import 'pages/home_page.dart';
import 'pages/task_tracker_page.dart';
import 'providers/note_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notes');

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteProvider>(
      create: (context) => NoteProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes App',
          initialRoute: '/home_page',
          routes: {
            '/home_page': (context) => const HomePage(),
            '/note_detail': (context) => const NoteDetailPage(),
            '/calendar_page': (context) => const CalendarPage(),
            '/task_tracker_page': (context) => const TaskTrackerPage(),
          }),
    );
  }
}
