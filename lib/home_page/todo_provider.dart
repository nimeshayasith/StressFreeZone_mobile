import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application/todo_list/todo_list.dart';
import 'package:flutter_application/todo_list/task.dart';

class ToDoProvider with ChangeNotifier {
  // List of to-do lists
  final List<TodoList> _todoLists = [];
  Timer? _timer;

  void initializePredefinedLists() {
    List<String> predefinedTiles = [
      'Daily Plan',
      'Weekly Plan',
      'Monthly Plan',
      'No Repeating Tasks Plan'
    ];

    for (String title in predefinedTiles) {
      if (!_todoLists.any((list) => list.title == title)) {
        _todoLists.add(TodoList(title: title, tasks: []));
      }
    }
    notifyListeners();
  }

  // To track the selected list index
  int _selectedListIndex = -1;

  List<TodoList> get todoLists => _todoLists;
  int get selectedListIndex => _selectedListIndex;

  // Get the selected list if any
  TodoList? get selectedList =>
      _selectedListIndex != -1 ? _todoLists[_selectedListIndex] : null;

  // Currently selected date
  DateTime? _selectedDate = DateTime.now();
  DateTime? get selectedDate => _selectedDate;

  void startTaskResetTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      resetTasks();
    });
  }

  void resetTasks() {
    final now = DateTime.now();
    final currentDay = now.day;
    final currentWeekday = now.weekday;

    if (now.hour == 0 && now.minute == 0) {
      final dailyList =
          _todoLists.firstWhere((list) => list.title == 'Daily Plan');
      for (var task in dailyList.tasks) {
        task.isDone = false;
      }
    }

    if (currentWeekday == 1 && now.hour == 0 && now.minute == 0) {
      final weeklyList =
          _todoLists.firstWhere((list) => list.title == 'Weekly Plan');
      for (var task in weeklyList.tasks) {
        task.isDone = false;
      }
    }

    if (currentDay == 1 && now.hour == 0 && now.minute == 0) {
      final monthlyList =
          _todoLists.firstWhere((list) => list.title == 'Monthly Plan');
      for (var task in monthlyList.tasks) {
        task.isDone = false;
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Add a new to-do list
  void addTodoList(String title) {
    if (_todoLists.any((list) => list.title == title)) {
      return;
    }
    _todoLists.add(TodoList(title: title, tasks: []));
    notifyListeners();
  }

  // Remove a to-do list
  void removeTodoList(int index) {
    if (index >= 0 && index < _todoLists.length) {
      final listToRemove = _todoLists[index];

      for (var todoList in _todoLists) {
        if (todoList.title != listToRemove.title) {
          todoList.tasks.removeWhere(
              (task) => listToRemove.tasks.any((t) => t.name == task.name));
        }
      }

      _todoLists.removeAt(index);
      if (_selectedListIndex == index) {
        _selectedListIndex = -1;
      } else if (_selectedListIndex > index) {
        _selectedListIndex--;
      }
      notifyListeners();
    }
  }

  void removeTask(int taskIndex) {
    if (_selectedListIndex != -1 &&
            taskIndex >= 0 &&
            taskIndex <
                _todoLists[_selectedListIndex]
                    .tasks
                    .length /*&&
        !isPredefinedList(selectedList!)*/
        ) {
      Task taskToRemove = _todoLists[_selectedListIndex].tasks[taskIndex];
      _todoLists[_selectedListIndex].tasks.removeAt(taskIndex);

      if (taskToRemove.routine == Routine.daily) {
        final dailyList =
            _todoLists.firstWhere((list) => list.title == 'Daily Plan');
        dailyList.tasks.removeWhere((task) => task.name == taskToRemove.name);
      } else if (taskToRemove.routine == Routine.weekly) {
        final weeklyList =
            _todoLists.firstWhere((list) => list.title == 'Weekly Plan');
        weeklyList.tasks.removeWhere((task) => task.name == taskToRemove.name);
      } else if (taskToRemove.routine == Routine.monthly) {
        final monthlyList =
            _todoLists.firstWhere((list) => list.title == 'Monthly Plan');
        monthlyList.tasks.removeWhere((task) => task.name == taskToRemove.name);
      } else if (taskToRemove.routine == Routine.none) {
        final noRepeatingList = _todoLists
            .firstWhere((list) => list.title == 'No Repeating Tasks Plan');
        noRepeatingList.tasks
            .removeWhere((task) => task.name == taskToRemove.name);
      }

      notifyListeners();
    }
  }

  // Select a to-do list
  void selectTodoList(int index) {
    if (index >= 0 && index < _todoLists.length) {
      _selectedListIndex = index;
      notifyListeners();
    } else {
      _selectedListIndex = -1;
      notifyListeners();
    }
  }

  // Add a task to the selected list
  void addTaskToSelectedList(Task task) {
    if (_selectedListIndex != -1 && !isPredefinedList(selectedList!)) {
      final selectedTasks = _todoLists[_selectedListIndex].tasks;
      if (selectedTasks.every((t) => t.name != task.name)) {
        selectedTasks.add(task);
        notifyListeners();
        updateRoutineLists(task);
      }
    }
  }

  void updateRoutineLists(Task task) {
    if (task.routine == Routine.daily) {
      final dailyList =
          _todoLists.firstWhere((list) => list.title == 'Daily Plan');
      dailyList.tasks.add(task);
    } else if (task.routine == Routine.weekly) {
      final weeklyList =
          _todoLists.firstWhere((list) => list.title == 'Weekly Plan');
      weeklyList.tasks.add(task);
    } else if (task.routine == Routine.monthly) {
      final monthlyList =
          _todoLists.firstWhere((list) => list.title == 'Monthly Plan');
      monthlyList.tasks.add(task);
    } else if (task.routine == Routine.none) {
      final noRepeatingList = _todoLists
          .firstWhere((list) => list.title == 'No Repeating Tasks Plan');
      noRepeatingList.tasks.add(task);
    }
    notifyListeners();
  }

  // Toggle the completion status of a task
  void toggleTaskCompletion(int taskIndex, bool isDone) {
    if (taskIndex >= 0 && _selectedListIndex != -1) {
      _todoLists[_selectedListIndex].tasks[taskIndex].isDone = isDone;
      notifyListeners();
    }
  }

  // Update a task name and routine
  void updateTask(
      int index, String newName, Routine newRoutine, DateTime? newDeadline) {
    if (selectedList != null &&
        index >= 0 &&
        index < selectedList!.tasks.length &&
        !isPredefinedList(selectedList!)) {
      Task currentTask = selectedList!.tasks[index];

      if (currentTask.routine != Routine.none) {
        final currentList = _todoLists.firstWhere(
            (list) => list.title == currentTask.routine.name + " Plan");
        currentList.tasks.remove(currentTask);
      }

      if (currentTask.routine == Routine.none && newRoutine != Routine.none) {
        final noRepeatingList = _todoLists
            .firstWhere((list) => list.title == 'No Repeating Tasks Plan');
        noRepeatingList.tasks.remove(currentTask);
      }

      currentTask.name = newName;
      currentTask.routine = newRoutine;
      currentTask.deadline = newDeadline;

      if (newRoutine != Routine.none) {
        final newList = _todoLists
            .firstWhere((list) => list.title == newRoutine.name + " Plan");
        newList.tasks.add(currentTask);
      } else {
        final noRepeatingList = _todoLists
            .firstWhere((list) => list.title == 'No Repeating Tasks Plan');
        if (!noRepeatingList.tasks.any((t) => t.name == currentTask.name)) {
          noRepeatingList.tasks.add(currentTask);
        }
      }
      notifyListeners();
    }
  }

  // Update a task's routine
  void updateRoutineTask(Task task) {
    for (var todoList in _todoLists) {
      final index = todoList.tasks.indexWhere((t) => t.name == task.name);
      if (index != -1) {
        todoList.tasks[index] = task;
        notifyListeners();
        return;
      }
    }
  }

  // Set a selected date
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void populateRoutineTasks() {
    final now = DateTime.now();

    for (var todoList in _todoLists) {
      if (todoList.title == 'Daily Plan') {
        todoList.tasks.addAll([
          Task(name: 'Example Daily Task 1', routine: Routine.daily),
        ]);
      } else if (todoList.title == 'Weekly Plan' &&
          now.weekday == DateTime.monday) {
        todoList.tasks.addAll([
          Task(name: 'Example Weekly Task 1', routine: Routine.weekly),
        ]);
      } else if (todoList.title == 'Monthly Plan' && now.day == 1) {
        todoList.tasks.addAll([
          Task(name: 'Example Monthly Task 1', routine: Routine.monthly),
        ]);
      }
    }
    notifyListeners();
  }

  List<Task> getTasksForSelectedDate() {
    if (_selectedDate == null || _selectedListIndex == -1) {
      return [];
    }
    return _todoLists[_selectedListIndex].tasks;
  }

  bool isPredefinedList(TodoList list) {
    return list.title == 'Daily Plan' ||
        list.title == 'Weekly Plan' ||
        list.title == 'Monthly Plan' ||
        list.title == 'No Repeating Tasks Plan';
  }

  // Optional: Get tasks for the selected date (if you have this requirement)
  /* List<Task> getTasksForSelectedDate() {
    return _tasks
        .where((task) => task.isDone == (_selectedDate != null))
        .toList();
  } */
}
