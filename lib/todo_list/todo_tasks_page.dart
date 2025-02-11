import 'package:flutter/material.dart';
import 'package:flutter_application/home_page/todo_provider.dart';
import 'package:provider/provider.dart';
import 'task.dart';

class TodoTasksPage extends StatelessWidget {
  const TodoTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);
    final selectedList = todoProvider.selectedList;

    if (selectedList == null) {
      return Center(
        child: Text('No to-do list selected. Please choose one.'),
      );
    }

    final incompleteTasks =
        selectedList.tasks.where((task) => !task.isDone).toList();
    final completedTasks =
        selectedList.tasks.where((task) => task.isDone).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedList.title),
        actions: [
          if (!isPredefinedList(selectedList.title))
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _showDeleteConfirmationDialog(context, todoProvider);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildTaskSection(
                    'Incomplete Tasks', incompleteTasks, context, todoProvider),
                const Divider(),
                _buildTaskSection(
                    'Completed Tasks', completedTasks, context, todoProvider),
              ],
            ),
          ),
          if (!isPredefinedList(selectedList.title))
            ElevatedButton(
              onPressed: () => _showAddTaskDialog(context, todoProvider),
              child: const Text('Add Task'),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskSection(String title, List<Task> tasks, BuildContext context,
      ToDoProvider todoProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        ...tasks.map((task) {
          final index = todoProvider.selectedList?.tasks.indexOf(task) ?? -1;
          return ListTile(
            leading: Checkbox(
              value: task.isDone,
              onChanged: (value) {
                todoProvider.toggleTaskCompletion(index, value ?? false);
              },
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: TextStyle(
                    decoration: task.isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                Text(
                  'Routine: ${task.routine.name.capitalize()}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Deadline: ${task.deadline != null ? task.deadline!.toLocal().toString().split(' ')[0] : 'Not Set'}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (task.deadline != null)
                  Text(
                    'Remaining: ${_getRemainingTime(task.deadline!)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
            trailing: isPredefinedList(todoProvider.selectedList!.title)
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showUpdateTaskDialog(
                              context, todoProvider, index, task);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          todoProvider.removeTask(index);
                        },
                      ),
                    ],
                  ),
          );
        }).toList(),
      ],
    );
  }

  String _getRemainingTime(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.isNegative) {
      return 'Deadline passed';
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    return '${days > 0 ? '$days days ' : ''}${hours > 0 ? '$hours hours ' : ''}${minutes > 0 ? '$minutes minutes ' : ''}';
  }

  bool isPredefinedList(String title) {
    return title == 'Daily Plan' ||
        title == 'Weekly Plan' ||
        title == 'Monthly Plan' ||
        title == 'No Repeating Tasks Plan';
  }

  void _showAddTaskDialog(BuildContext context, ToDoProvider todoProvider) {
    TextEditingController taskNameController = TextEditingController();
    Routine selectedRoutine = Routine.none;
    DateTime? selectedDeadline;
    int? selectedDayOfWeek;
    int? selectedDayOfMonth;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add a New Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskNameController,
                    decoration: const InputDecoration(hintText: 'Task Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Routine',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton<Routine>(
                    value: selectedRoutine,
                    onChanged: (value) {
                      setState(() {
                        selectedRoutine = value ?? Routine.none;
                        selectedDeadline = null;
                        selectedDayOfWeek = null;
                        selectedDayOfMonth = null;
                      });
                    },
                    items: Routine.values.map((routine) {
                      return DropdownMenuItem<Routine>(
                        value: routine,
                        child: Text(routine.name.capitalize()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Deadline (Optional)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  if (selectedRoutine == Routine.none)
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDeadline ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            selectedDeadline = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          }
                        }
                        setState(() {});
                      },
                      child: Text(selectedDeadline == null
                          ? 'Select Deadline'
                          : 'Deadline: ${selectedDeadline!.toLocal().day}/${selectedDeadline!.toLocal().month}/${selectedDeadline!.toLocal().year} ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                    ),
                  if (selectedRoutine == Routine.daily)
                    TextButton(
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          selectedDeadline = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        }
                        setState(() {});
                      },
                      child: Text(selectedDeadline == null
                          ? 'Select Time'
                          : 'Time: ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                    ),
                  if (selectedRoutine == Routine.weekly)
                    Column(
                      children: [
                        DropdownButton<int>(
                          hint: const Text('Select Day of Week'),
                          items: [
                            DropdownMenuItem(value: 1, child: Text('Monday')),
                            DropdownMenuItem(value: 2, child: Text('Tuesday')),
                            DropdownMenuItem(
                                value: 3, child: Text('Wednesday')),
                            DropdownMenuItem(value: 4, child: Text('Thursday')),
                            DropdownMenuItem(value: 5, child: Text('Friday')),
                            DropdownMenuItem(value: 6, child: Text('Saturday')),
                            DropdownMenuItem(value: 7, child: Text('Sunday')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                selectedDayOfWeek = value;
                                selectedDeadline = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day +
                                      (value - DateTime.now().weekday + 7) % 7,
                                  selectedDeadline?.hour ?? 0,
                                  selectedDeadline?.minute ?? 0,
                                );
                              }
                            });
                          },
                          value: selectedDayOfWeek,
                        ),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              selectedDeadline = DateTime(
                                selectedDeadline?.year ?? DateTime.now().year,
                                selectedDeadline?.month ?? DateTime.now().month,
                                selectedDeadline?.day ?? DateTime.now().day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                            setState(() {});
                          },
                          child: Text(selectedDeadline == null
                              ? 'Select Time'
                              : 'Time: ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                        ),
                      ],
                    ),
                  if (selectedRoutine == Routine.monthly)
                    Column(
                      children: [
                        DropdownButton<int>(
                          hint: const Text('Select Day of Month'),
                          items: List.generate(
                              getDaysInMonth(
                                  DateTime.now().month, DateTime.now().year),
                              (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text('${index + 1}'),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                selectedDayOfMonth = value;
                                selectedDeadline = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  value,
                                  selectedDeadline?.hour ?? 0,
                                  selectedDeadline?.minute ?? 0,
                                );
                              }
                            });
                          },
                          value: selectedDayOfMonth,
                        ),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              selectedDeadline = DateTime(
                                selectedDeadline?.year ?? DateTime.now().year,
                                selectedDeadline?.month ?? DateTime.now().month,
                                selectedDeadline?.day ?? DateTime.now().day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                            setState(() {});
                          },
                          child: Text(selectedDeadline == null
                              ? 'Select Time'
                              : 'Time: ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                        ),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    todoProvider.addTaskToSelectedList(
                      Task(
                        name: taskNameController.text,
                        routine: selectedRoutine,
                        deadline: selectedDeadline,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  int getDaysInMonth(int month, int year) {
    if (month == 2) {
      bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    return 31;
  }

  void _showUpdateTaskDialog(
      BuildContext context, ToDoProvider todoProvider, int index, Task task) {
    TextEditingController taskNameController =
        TextEditingController(text: task.name);
    Routine selectedRoutine = task.routine;
    DateTime? selectedDeadline = task.deadline;
    int? selectedDayOfWeek;
    int? selectedDayOfMonth;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Update Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: taskNameController,
                    decoration: const InputDecoration(hintText: 'Task Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Routine',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DropdownButton<Routine>(
                    value: selectedRoutine,
                    onChanged: (value) {
                      setState(() {
                        selectedRoutine = value ?? Routine.none;
                        selectedDeadline = null;
                        selectedDayOfWeek = null;
                        selectedDayOfMonth = null;
                      });
                    },
                    items: Routine.values.map((routine) {
                      return DropdownMenuItem<Routine>(
                        value: routine,
                        child: Text(routine.name.capitalize()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Deadline (Optional)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  if (selectedRoutine == Routine.none)
                    TextButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDeadline ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            selectedDeadline = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                          }
                        }
                        setState(() {});
                      },
                      child: Text(selectedDeadline == null
                          ? 'Select Deadline'
                          : 'Deadline: ${selectedDeadline!.toLocal().day}/${selectedDeadline!.toLocal().month}/${selectedDeadline!.toLocal().year} ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                    ),
                  if (selectedRoutine == Routine.daily)
                    TextButton(
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          selectedDeadline = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        }
                        setState(() {});
                      },
                      child: Text(selectedDeadline == null
                          ? 'Select Time'
                          : 'Time: ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                    ),
                  if (selectedRoutine == Routine.weekly)
                    Column(
                      children: [
                        DropdownButton<int>(
                          hint: const Text('Select Day of Week'),
                          items: [
                            DropdownMenuItem(value: 1, child: Text('Monday')),
                            DropdownMenuItem(value: 2, child: Text('Tuesday')),
                            DropdownMenuItem(
                                value: 3, child: Text('Wednesday')),
                            DropdownMenuItem(value: 4, child: Text('Thursday')),
                            DropdownMenuItem(value: 5, child: Text('Friday')),
                            DropdownMenuItem(value: 6, child: Text('Saturday')),
                            DropdownMenuItem(value: 7, child: Text('Sunday')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                selectedDayOfWeek = value;
                                selectedDeadline = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day +
                                      (value - DateTime.now().weekday + 7) % 7,
                                  selectedDeadline?.hour ?? 0,
                                  selectedDeadline?.minute ?? 0,
                                );
                              }
                            });
                          },
                          value: selectedDayOfWeek,
                        ),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              selectedDeadline = DateTime(
                                selectedDeadline?.year ?? DateTime.now().year,
                                selectedDeadline?.month ?? DateTime.now().month,
                                selectedDeadline?.day ?? DateTime.now().day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                            setState(() {});
                          },
                          child: Text(selectedDeadline == null
                              ? 'Select Time'
                              : 'Time: ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                        ),
                      ],
                    ),
                  if (selectedRoutine == Routine.monthly)
                    Column(
                      children: [
                        DropdownButton<int>(
                          hint: const Text('Select Day of Month'),
                          items: List.generate(
                              getDaysInMonth(
                                  DateTime.now().month, DateTime.now().year),
                              (index) {
                            return DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text('${index + 1}'),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                selectedDayOfMonth = value;
                                selectedDeadline = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  value,
                                  selectedDeadline?.hour ?? 0,
                                  selectedDeadline?.minute ?? 0,
                                );
                              }
                            });
                          },
                          value: selectedDayOfMonth,
                        ),
                        TextButton(
                          onPressed: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              selectedDeadline = DateTime(
                                selectedDeadline?.year ?? DateTime.now().year,
                                selectedDeadline?.month ?? DateTime.now().month,
                                selectedDeadline?.day ?? DateTime.now().day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            }
                            setState(() {});
                          },
                          child: Text(selectedDeadline == null
                              ? 'Select Time'
                              : 'Time: ${selectedDeadline!.toLocal().hour.toString().padLeft(2, '0')}:${selectedDeadline!.toLocal().minute.toString().padLeft(2, '0')}'),
                        ),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    todoProvider.updateTask(index, taskNameController.text,
                        selectedRoutine, selectedDeadline);
                    /*if (selectedRoutine == Routine.none) {
                      task.deadline = selectedDeadline;
                    }*/
                    Navigator.of(context).pop();
                  },
                  child: const Text('Update'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, ToDoProvider todoProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete All Tasks'),
          content: const Text(
              'Are you sure you want to delete all tasks in this list?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                todoProvider.selectedList?.tasks.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

extension StringExtention on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
