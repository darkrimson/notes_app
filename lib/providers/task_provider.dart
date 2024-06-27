import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  late Box<Task> _taskBox;

  List<Task> get tasks => _taskBox.values.toList();

  TaskProvider() {
    _init();
  }

  Future<void> _init() async {
    _taskBox = Hive.box<Task>('tasks');
    await clearTaskOfPreviousDay();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskBox.add(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await task.save();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await task.delete();
    notifyListeners();
  }

  List<Task> getTasksByDate(DateTime date) {
    return _taskBox.values.where((task) => isSameDay(task.date, date)).toList();
  }

  List<Task> getCompletedTasks() {
    return _taskBox.values.where((task) => task.isCompleted).toList();
  }

  List<Task> getPendingTasks() {
    return _taskBox.values.where((task) => !task.isCompleted).toList();
  }

  Future<void> clearTaskOfPreviousDay() async {
    final now = DateTime.now();
    final previousDay = DateTime(now.year, now.month, now.day - 1);
    final tasksToDelete = _taskBox.values
        .where((task) => task.date.isBefore(previousDay) && !task.isCompleted)
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
