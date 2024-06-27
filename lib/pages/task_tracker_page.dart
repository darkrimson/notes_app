import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_app/providers/task_provider.dart';

class TaskTrackerPage extends StatelessWidget {
  const TaskTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                final completedTasks = taskProvider.getCompletedTasks();
                return Column(
                  children: [
                    const Text('Completed Tasks',
                        style: TextStyle(fontSize: 20)),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: completedTasks.length,
                      itemBuilder: (context, index) {
                        final task = completedTasks[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.content),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                final pendingTasks = taskProvider.getPendingTasks();
                return Column(
                  children: [
                    const Text('Pending Tasks', style: TextStyle(fontSize: 20)),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: pendingTasks.length,
                      itemBuilder: (context, index) {
                        final task = pendingTasks[index];
                        return ListTile(
                          title: Text(task.title),
                          subtitle: Text(task.content),
                          trailing: Checkbox(
                            value: task.isCompleted,
                            onChanged: (bool? value) {
                              task.isCompleted = value!;
                              taskProvider.updateTask(task);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
