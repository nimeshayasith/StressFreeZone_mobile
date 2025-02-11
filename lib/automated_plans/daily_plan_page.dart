import 'package:flutter/material.dart';
import 'package:flutter_application/todo_list/todo_list.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';

class DailyPlanPage extends StatelessWidget {
  const DailyPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final dailyTasks = provider.todoLists
        .firstWhere((list) => list.title == "Daily Plan",
            orElse: () => TodoList(title: "Daily Plan", tasks: []))
        .tasks;

    return Scaffold(
      appBar: AppBar(title: Text("Daily Plan")),
      body: dailyTasks.isEmpty
          ? const Center(child: Text("No Daily Tasks"))
          : ListView(
              children: dailyTasks.map((task) {
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
