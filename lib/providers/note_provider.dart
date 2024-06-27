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
    _noteBox = Hive.box<Note>('notes');
    await clearTaskOfPreviousDay();
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

  List<Note> getTasksByDate(DateTime date) {
    return _noteBox.values.where((note) => isSameDay(note.date, date)).toList();
  }

  List<Note> getCompletedTasks() {
    return _noteBox.values.where((note) => note.isCompleted).toList();
  }

  List<Note> getPendingTasks() {
    return _noteBox.values.where((note) => !note.isCompleted).toList();
  }

  Future<void> clearTaskOfPreviousDay() async {
    final now = DateTime.now();
    final previousDay = DateTime(now.year, now.month, now.day - 1);
    final tasksToDelete = _noteBox.values
        .where((note) => note.date.isBefore(previousDay) && !note.isCompleted)
        .toList();
    for (final task in tasksToDelete) {
      await task.delete();
    }
    notifyListeners();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
