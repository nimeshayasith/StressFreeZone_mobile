import 'package:flutter/material.dart';
import 'package:flutter_application/screens/todo_list/todo_list.dart';
import 'package:flutter_application/screens/todo_list/todo_tasks_page.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  void initState() {
    super.initState();
    final todoProvider = Provider.of<ToDoProvider>(context, listen: false);
    todoProvider.initializePredefinedLists();
    todoProvider.startTaskResetTimer();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);

    List<TodoList> predefinedLists = [
      TodoList(title: 'Daily Plan', tasks: []),
      TodoList(title: 'Weekly Plan', tasks: []),
      TodoList(title: 'Monthly Plan', tasks: []),
      TodoList(title: 'No Repeating Tasks Plan', tasks: []),
    ];

    List<TodoList> allLists = [...todoProvider.todoLists, ...predefinedLists];

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todoProvider.todoLists.length,
              itemBuilder: (context, index) {
                final todoList = todoProvider.todoLists[index];
                return ListTile(
                  title: Text(todoList.title),
                  subtitle: todoList.title.contains("Plan")
                      ? const Text("Predefined list")
                      : null,
                  trailing: todoList.title.contains("Plan")
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteConfirmation(
                                context, todoProvider, index);
                          },
                        ),
                  onTap: () {
                    todoProvider.selectTodoList(index);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TodoTasksPage(),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _showAddTodoListDialog(context, todoProvider),
            child: const Text('Create New To-Do List'),
          ),
        ],
      ),
    );
  }

  void _showAddTodoListDialog(BuildContext context, ToDoProvider todoProvider) {
    TextEditingController listTitleController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New To-Do List'),
          content: TextField(
            controller: listTitleController,
            decoration: const InputDecoration(hintText: 'List Title'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoProvider.addTodoList(listTitleController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, ToDoProvider todoProvider, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete To-Do List'),
          content: Text(
              'Are you sure you want tp delete the "${todoProvider.todoLists[index].title}" to-do list? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                todoProvider.removeTodoList(index);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
