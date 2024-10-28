import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todoProvider.tasks.length,
                itemBuilder: (context, index) {
                  final task = todoProvider.tasks[index];
                  return ListTile(
                    title: Text(task.name),
                    subtitle: Text(task.category),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: task.isDone,
                          onChanged: (bool? value) {
                            todoProvider.toggleTaskCompletion(index, value!);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            todoProvider.removeTask(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showAddTaskDialog(context, todoProvider);
              },
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context, ToDoProvider todoProvider) {
    TextEditingController taskNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new Task'),
          content: TextField(
            controller: taskNameController,
            decoration: const InputDecoration(hintText: 'Task name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                todoProvider.addTask(Task(name: taskNameController.text));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
