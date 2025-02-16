import 'package:flutter/material.dart';
import 'package:flutter_application/screens/todo_list/todo_list.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';

class MonthlyPlanPage extends StatelessWidget {
  const MonthlyPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final monthlyTasks = provider.todoLists
        .firstWhere((list) => list.title == "Monthly Plan",
            orElse: () => TodoList(title: "Monthly Plan", tasks: []))
        .tasks;

    return Scaffold(
      appBar: AppBar(title: Text("Monthly Plan")),
      body: monthlyTasks.isEmpty
          ? Center(child: Text("No Monthly Tasks"))
          : ListView(
              children: monthlyTasks.map((task) {
                return ListTile(
                  title: Text(task.name),
                  trailing: Checkbox(
                    value: task.isDone,
                    onChanged: (value) {
                      task.isDone = value!;
                      provider.updateRoutineTask(task);
                    },
                  ),
                );
              }).toList(),
            ),
    );
  }
}
