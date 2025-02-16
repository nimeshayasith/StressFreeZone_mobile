import 'tracker.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';

class MovementService {
  final Tracker tracker;

  MovementService(this.tracker) {
    _startListening();
  }

  void _startListening() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      double speed = _calculateSpeed(event);
      if (speed > 2.00) {
        tracker.updateDistance(1.00, true);
      } else {
        tracker.updateDistance(1.00, false);
      }
    });
  }

  double _calculateSpeed(AccelerometerEvent event) {
    return sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
  }
}
