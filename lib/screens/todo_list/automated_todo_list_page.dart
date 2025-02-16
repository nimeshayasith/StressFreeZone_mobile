import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';
import 'task.dart'; // Ensure this import is present
import 'automated_todo_list.dart';

class AutomatedTodoListPage extends StatelessWidget {
  const AutomatedTodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);
    final automatedTodoList = AutomatedTodoList();
    automatedTodoList
        .generateAutomatedTasks(todoProvider.selectedList?.tasks ?? []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Automated To-Do Lists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTaskSection('Daily Tasks', automatedTodoList.dailyTasks),
            const Divider(),
            _buildTaskSection('Weekly Tasks', automatedTodoList.weeklyTasks),
            const Divider(),
            _buildTaskSection('Monthly Tasks', automatedTodoList.monthlyTasks),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSection(String title, List<Task> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        ...tasks.map((task) {
          return ListTile(
            title: Text(task.name), // Use null-aware operator if necessary
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                // Handle task completion toggle
              },
            ),
          );
        }), // Removed unnecessary toList()
      ],
    );
  }
}
