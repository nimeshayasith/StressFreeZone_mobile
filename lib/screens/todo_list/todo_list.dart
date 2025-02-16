import 'task.dart';

class TodoList {
  String title;
  List<Task> tasks;
  //List<ToDoTask> allDayTasks;
  //List<ToDoTask> reminderTasks;
  //List<ToDoTask> noTagTasks;

  TodoList({required this.title, this.tasks = const []});
}
