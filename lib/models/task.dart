import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  DateTime date; // Добавлено свойство даты

  @HiveField(4)
  bool isCompleted = false; // Добавлено свойство для трекера задач

  Task({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.date,
    this.isCompleted = false,
  });
}
