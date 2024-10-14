import 'package:flutter/material.dart';

class Task {
  final String name;
  final String category;
  bool isDone;

  Task({required this.name, this.category = 'No tag', this.isDone = false});
}

class ToDoProvider with ChangeNotifier {
  List<Task> _tasks = [];
  DateTime? _selectedDate;

  List<Task> get tasks => _tasks;
  DateTime? get selectedDate => _selectedDate;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(int index, bool isDone) {
    _tasks[index].isDone = isDone;
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
