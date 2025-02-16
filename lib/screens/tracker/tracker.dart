import 'package:flutter/material.dart';

class Tracker with ChangeNotifier {
  double _totalDistance = 0.00;
  double _walkingDistance = 0.00;
  double _runningDistance = 0.00;
  double _caloriesBurned = 0.00;
  double _waterIntake = 0.00;
  final double _waterGoal = 6.00;

  double get totalDistance => _totalDistance;
  double get walkingDistance => _walkingDistance;
  double get runningDistance => _runningDistance;
  double get caloriesBurned => _caloriesBurned;
  double get waterIntake => _waterIntake;
  double get waterGoal => _waterGoal;

  void updateDistance(double distance, bool isRunning) {
    _totalDistance += distance;
    if (isRunning) {
      _runningDistance += distance;
    } else {
      _walkingDistance += distance;
    }
    _caloriesBurned += _calculateCalories(distance);
    notifyListeners();
  }

  double _calculateCalories(double distance) {
    return distance * 0.05;
  }

  void addWater(double liters) {
    _waterIntake += liters;
    notifyListeners();
  }

  void resetTracker() {
    _totalDistance = 0.00;
    _walkingDistance = 0.00;
    _runningDistance = 0.00;
    _caloriesBurned = 0.00;
    _waterIntake = 0.00;
    notifyListeners();
  }
}
