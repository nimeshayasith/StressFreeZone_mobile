enum Routine {
  none,
  daily,
  weekly,
  monthly,
}

extension RoutineExtension on Routine {
  String get name {
    switch (this) {
      case Routine.daily:
        return 'Daily';
      case Routine.weekly:
        return 'Weekly';
      case Routine.monthly:
        return 'Monthly';
      case Routine.none:
        return 'None';
    }
  }
}

class Task {
  String name;
  bool isDone;
  Routine routine;
  DateTime? deadline;

  Task({
    required this.name,
    this.isDone = false,
    this.routine = Routine.none,
    this.deadline,
  });
}
