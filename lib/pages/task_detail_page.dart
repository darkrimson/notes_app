import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/models/task.dart';
import 'package:tasks_app/providers/task_provider.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Task? task = ModalRoute.of(context)!.settings.arguments as Task?;
    final titleController = TextEditingController(text: task?.title ?? '');
    final contentController = TextEditingController(text: task?.content ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
        actions: [
          if (task != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false)
                    .deleteTask(task);
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

                final taskProvider =
                    Provider.of<TaskProvider>(context, listen: false);

                if (task == null) {
                  final newTask = Task(
                    title: title,
                    content: content,
                    createdAt: DateTime.now(),
                    date: DateTime.now(),
                  );
                  taskProvider.addTask(newTask);
                } else {
                  task.title = title;
                  task.content = content;
                  taskProvider.updateTask(task);
                }

                Navigator.pop(context);
              },
              child: Text(task == null ? 'Add Task' : 'Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
