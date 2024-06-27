import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/task_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Tasks $formattedDate'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteTask(task);
                  },
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/task_detail', arguments: task);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/task_detail'),
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text('Navigation'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Calendar'),
              onTap: () {
                Navigator.pushNamed(context, '/calendar_page');
              },
            ),
            ListTile(
              title: const Text('Task Tracker'),
              onTap: () {
                Navigator.pushNamed(context, '/task_tracker_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
