import 'package:flutter/material.dart';
import 'package:tasks_app/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2100, 1, 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                final tasks = taskProvider.getTasksByDate(_selectedDay);
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('No tasks for this day'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
