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

        // Update distance based on the type of movement
        tracker.updateDistance(0.1, isRunning); // Adjust distance per detection
      }
    });
  }
}
