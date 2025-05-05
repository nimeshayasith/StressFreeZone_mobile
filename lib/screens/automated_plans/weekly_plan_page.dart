import 'package:flutter/material.dart';
import 'package:flutter_application/screens/todo_list/todo_list.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';

class WeeklyPlanPage extends StatelessWidget {
  const WeeklyPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final weeklyTasks = provider.todoLists
        .firstWhere((list) => list.title == "Weekly Plan",
            orElse: () => TodoList(title: "Weekly Plan", tasks: []))
        .tasks;

    return Scaffold(
      appBar: AppBar(title: Text("Weekly Plan")),
      body: weeklyTasks.isEmpty
          ? Center(child: Text("No Weekly Tasks"))
          : ListView(
              children: weeklyTasks.map((task) {
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
