import 'package:flutter/material.dart';
import 'task.dart';

class AutomatedTodoList {
  final List<Task> dailyTasks = [];
  final List<Task> weeklyTasks = [];
  final List<Task> monthlyTasks = [];

  void generateAutomatedTasks(List<Task> userTasks) {
    dailyTasks.clear();
    weeklyTasks.clear();
    monthlyTasks.clear();

    for (var task in userTasks) {
      switch (task.routine) {
        case Routine.daily:
          dailyTasks.add(task);
          break;
        case Routine.weekly:
          weeklyTasks.add(task);
          break;
        case Routine.monthly:
          monthlyTasks.add(task);
          break;
        case Routine.none:
          break;
      }
    }
  }
}
