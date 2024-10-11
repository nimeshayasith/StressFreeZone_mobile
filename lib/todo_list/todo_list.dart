class TodoList {
  String name;
  List<ToDoTask> todayTasks;
  List<ToDoTask> allDayTasks;
  List<ToDoTask> reminderTasks;
  List<ToDoTask> noTagTasks;

  ToDoList({
    required this.name;
    this.todayTasks = const [],
    this.allDayTasks = const [],
    this.reminderTasks = const [],
    this.noTagTasks = const [],
  });
}

class ToDoTask {
  String title;
  bool isCompleted;
  
  ToDoTask({
    required this.title,
    this.isCompleted = false,
  });
}
