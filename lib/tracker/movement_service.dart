import 'tracker.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class MovementService {
  final Tracker tracker;
  double _gravityX = 0;
  double _gravityY = 0;
  double _gravityZ = 0;
  final double _alpha = 0.8;

  // Define thresholds for walking and running
  final double walkingThreshold = 1.5; // Example threshold for walking
  final double runningThreshold = 2.5; // Example threshold for running

  // Variables to track distance
  double _totalDistance = 0.0; // Total distance traveled
  double _lastUpdateDistance = 0.0; // Distance since last update

  MovementService(this.tracker) {
    _startListening();
  }

  void _startListening() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      _gravityX = _alpha * _gravityX + (1 - _alpha) * event.x;
      _gravityY = _alpha * _gravityY + (1 - _alpha) * event.y;
      _gravityZ = _alpha * _gravityZ + (1 - _alpha) * event.z;

      double dynamicX = event.x - _gravityX;
      double dynamicY = event.y - _gravityY;
      double dynamicZ = event.z - _gravityZ;

      double accelerationMagnitude =
          sqrt(dynamicX * dynamicX + dynamicY * dynamicY + dynamicZ * dynamicZ);

      if (accelerationMagnitude > walkingThreshold) {
        // Determine if the movement is running or walking
        bool isRunning = accelerationMagnitude > runningThreshold;

        // Calculate the distance traveled based on the acceleration
        // Here we assume a simple model where we consider the magnitude of acceleration
        // to estimate distance. This is a simplification and may need refinement.
        double distanceTraveled = accelerationMagnitude * 0.1; // Scale factor

        // Accumulate the distance
        _totalDistance += distanceTraveled;

        // Check if we have reached 2 meters to update the tracker
        if (_totalDistance - _lastUpdateDistance >= 2.0) {
          tracker.updateDistance(
              2.0, isRunning); // Update the tracker with 2 meters
          _lastUpdateDistance += 2.0; // Update the last update distance
        }
      }
    });
  }
}
