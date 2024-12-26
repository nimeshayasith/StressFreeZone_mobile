import 'package:flutter/material.dart';

class Task {
  final String name;
  final String category;
  bool isDone;

  Task({required this.name, this.category = 'No tag', this.isDone = false});

  Task copyWith({String? name, String? category, bool? isDone}) {
    return Task(
      name: name ?? this.name,
      category: category ?? this.category,
      isDone: isDone ?? this.isDone,
    );
  }
}

class ToDoProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  DateTime? _selectedDate = DateTime.now();

  List<Task> get tasks => _tasks;
  DateTime? get selectedDate => _selectedDate;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTaskCompletion(int index, bool isDone) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks[index].isDone = isDone;
    notifyListeners();
  }

  void removeTask(int index) {
    if (index < 0 || index >= _tasks.length) return;
    _tasks.removeAt(index);
    notifyListeners();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  List<Task> getTasksForSelectedDate() {
    //............................................
    return _tasks
        .where((task) => task.isDone == (_selectedDate != null))
        .toList();
  }
}
