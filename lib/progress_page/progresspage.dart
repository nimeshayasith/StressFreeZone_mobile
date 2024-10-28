import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';
import 'dart:async';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int _selectedIndex = 2;
  late Timer _timer;
  String _remainingTime = '';

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _updateRemainingTime();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day + 1);
    final remainingDuration = midnight.difference(now);

    setState(() {
      _remainingTime =
          "${remainingDuration.inHours.toString().padLeft(2, '0')}:${(remainingDuration.inMinutes % 60).toString().padLeft(2, '0')}";
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/discover');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/progress');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);
    final tasks = todoProvider.tasks;
    final completedTasks = tasks.where((task) => task.isDone).length;
    final overallProgress =
        tasks.isNotEmpty ? completedTasks / tasks.length : 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Remaining time: $_remainingTime",
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: overallProgress,
                center: Text(
                  "${(overallProgress * 100).toStringAsFixed(0)}%",
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.teal,
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              "Daily Sessions",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(tasks[index].name),
                    value: tasks[index].isDone,
                    onChanged: (value) {
                      todoProvider.toggleTaskCompletion(index, value!);
                    },
                    activeColor: Colors.teal,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(Icons.show_chart), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
