import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  late Box<Note> _noteBox;

  List<Note> get notes => _noteBox.values.toList();

  NoteProvider() {
    _init();
  }

  Future<void> _init() async {
    _noteBox = await Hive.box<Note>('notes');
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _noteBox.add(note);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    await note.save();
    notifyListeners();
  }

  Future<void> deleteNote(Note note) async {
    await note.delete();
    notifyListeners();
  }
}
