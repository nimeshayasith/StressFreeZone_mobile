import 'package:flutter/material.dart';
import 'package:flutter_application/screens/todo_list/todo_list.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';

class NoRepeatingPlanPage extends StatelessWidget {
  const NoRepeatingPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final nonRepeatingTasks = provider.todoLists
        .firstWhere((list) => list.title == "Non-Repeating Plan",
            orElse: () => TodoList(title: "Non-Repeating Plan", tasks: []))
        .tasks;

    return Scaffold(
      appBar: AppBar(title: Text("Non-Repeating Plan")),
      body: nonRepeatingTasks.isEmpty
          ? Center(child: Text("No Non-Repeating Tasks"))
          : ListView(
              children: nonRepeatingTasks.map((task) {
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
