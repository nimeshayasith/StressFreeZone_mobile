import 'package:flutter/material.dart';
import 'package:flutter_application/screens/todo_list/task.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../home_page/todo_provider.dart';
import 'dart:async';
import 'package:flutter_application/screens/tracker/tracker.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:flutter_application/todo_list/todo_list.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  ProgressPageState createState() => ProgressPageState();
}

class ProgressPageState extends State<ProgressPage> {
  int _selectedIndex = 2;
  late Timer _timer;
  String _remainingTime = '';
  String _selectedPlan = 'Daily Plan'; // Default selected plan

  @override
  void initState() {
    super.initState();
    _updateRemainingTime();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
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
    final tasks = todoProvider.selectedList?.tasks ?? [];
    final tracker = Provider.of<Tracker>(context);

    // Filter tasks based on the selected plan
    List<Task> filteredTasks = [];
    if (_selectedPlan == 'Daily Plan') {
      filteredTasks =
          tasks.where((task) => task.routine == Routine.daily).toList();
    } else if (_selectedPlan == 'Weekly Plan') {
      filteredTasks =
          tasks.where((task) => task.routine == Routine.weekly).toList();
    } else if (_selectedPlan == 'Monthly Plan') {
      filteredTasks =
          tasks.where((task) => task.routine == Routine.monthly).toList();
    } else if (_selectedPlan == 'No Repeating Tasks Plan') {
      filteredTasks =
          tasks.where((task) => task.routine == Routine.none).toList();
    }

    final incompleteTasks =
        filteredTasks.where((task) => !task.isDone).toList();
    final completedTasks = filteredTasks.where((task) => task.isDone).toList();
    final overallProgress = filteredTasks.isNotEmpty
        ? completedTasks.length / filteredTasks.length
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Progress"),
      ),
      body: SingleChildScrollView(
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
            const SizedBox(height: 24),
            const Text("Select Plan",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildPlanButton('Daily Plan', Icons.calendar_today),
                  const SizedBox(width: 8),
                  _buildPlanButton('Weekly Plan', Icons.calendar_view_week),
                  const SizedBox(width: 8),
                  _buildPlanButton('Monthly Plan', Icons.calendar_month),
                  const SizedBox(width: 8),
                  _buildPlanButton('No Repeating Tasks Plan', Icons.event_busy),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text("Tasks",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...incompleteTasks.map((task) => CheckboxListTile(
                      title: Text(task.name),
                      value: task.isDone,
                      onChanged: (value) {
                        todoProvider.toggleTaskCompletion(
                            filteredTasks.indexOf(task), value!);
                      },
                      activeColor: Colors.teal,
                      secondary: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          todoProvider.removeTask(filteredTasks.indexOf(task));
                          setState(() {});
                        },
                      ),
                    )),
                const SizedBox(height: 16),
                if (completedTasks.isNotEmpty)
                  const Text("Completed Tasks",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ...completedTasks.map((task) => CheckboxListTile(
                      title: Text(
                        task.name,
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                      value: task.isDone,
                      onChanged: (value) {
                        todoProvider.toggleTaskCompletion(
                            filteredTasks.indexOf(task), value!);
                      },
                      activeColor: Colors.teal,
                      secondary: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          todoProvider.removeTask(filteredTasks.indexOf(task));
                          setState(() {});
                        },
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Tracker Information",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 16,
            ),
            _buildSection(
              "Total Distance",
              tracker.totalDistance,
              Colors.blue,
              _buildBarChart(tracker.totalDistance, Colors.blue),
            ),
            const Divider(),
            _buildSection(
              "Walking Distance",
              tracker.walkingDistance,
              Colors.green,
              _buildBarChart(tracker.totalDistance, Colors.green),
            ),
            const Divider(),
            _buildSection(
              "Running Distance",
              tracker.runningDistance,
              Colors.red,
              _buildBarChart(tracker.totalDistance, Colors.red),
            ),
            const Divider(),
            _buildSection(
              "Calories Burned",
              tracker.caloriesBurned,
              Colors.orange,
              _buildBarChart(tracker.totalDistance, Colors.orange),
            ),
            const Divider(),
            _buildWaterIntakeCard(tracker),
            /*const SizedBox(
              height: 28,
            ),
            Text("Distance Breakdown",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 200,
              child: BarChart(BarChartData(barGroups: [
                BarChartGroupData(x: 0, barRods: [
                  BarChartRodData(
                      toY: tracker.walkingDistance, color: Colors.blue)
                ]),
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(
                      toY: tracker.runningDistance, color: Colors.red)
                ])
              ])),
            ),*/
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

  Widget _buildSection(String title, double value, Color color, Widget graph) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(fontSize: 24, color: color),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 200,
          child: graph,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget _buildBarChart(double value, Color color) {
    return BarChart(BarChartData(
      barGroups: [
        BarChartGroupData(x: 0, barRods: [
          BarChartRodData(toY: value, color: color, width: 15),
        ])
      ],
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
    ));
  }

  Widget _buildPlanButton(String planName, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = planName;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _selectedPlan == planName ? Colors.teal : Colors.grey,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              planName,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  /*Widget _buildTrackerCard(String title, double value, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24, color: color),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildWaterIntakeCard(Tracker tracker) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Water Intake",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${tracker.waterIntake.toStringAsFixed(2)} l / ${tracker.waterGoal} l",
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
            const SizedBox(
              height: 16,
            ),
            LinearPercentIndicator(
              lineHeight: 20.0,
              percent:
                  (tracker.waterIntake / tracker.waterGoal).clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              progressColor: Colors.blue,
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                tracker.addWater(0.25);
              },
              child: const Text("Add 0.25 l Water"),
            ),
          ],
        ),
      ),
    );
  }
}
