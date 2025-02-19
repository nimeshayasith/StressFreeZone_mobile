// import 'package:location/location.dart';
// import 'dart:async';
// import 'package:geolocator/geolocator.dart';
// import 'package:sensors_plus/sensors_plus.dart'; // Updated import for accelerometer data

// class DistanceTracker {
//   Location _location = Location();
//   StreamSubscription<LocationData>? _locationSubscription;
//   double _totalDistance = 0.0;
//   double _runningDistance = 0.0;
//   double _walkingDistance = 0.0;
//   double _totalCaloriesBurned = 0.0;
//   Position? _lastPosition;
//   double _lastSpeed = 0.0;
//   bool _isRunning = false;

//   double get totalDistance => _totalDistance;
//   double get runningDistance => _runningDistance;
//   double get walkingDistance => _walkingDistance;
//   double get totalCaloriesBurned => _totalCaloriesBurned;

//   // Start tracking location and activity
//   void startTracking() async {
//     bool serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) {
//         return;
//       }
//     }

//     PermissionStatus permissionStatus = await _location.hasPermission();
//     if (permissionStatus == PermissionStatus.denied) {
//       permissionStatus = await _location.requestPermission();
//       if (permissionStatus != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationSubscription =
//         _location.onLocationChanged.listen((LocationData currentLocation) {
//       if (_lastPosition != null) {
//         double distance = Geolocator.distanceBetween(
//           _lastPosition!.latitude,
//           _lastPosition!.longitude,
//           currentLocation.latitude!,
//           currentLocation.longitude!,
//         );

//         _totalDistance += distance;

//         // Detect if walking or running
//         if (_lastSpeed > 5.0) {
//           // Speed threshold for running (e.g., 5 m/s)
//           _runningDistance += distance;
//         } else {
//           _walkingDistance += distance;
//         }

//         _lastSpeed = currentLocation.speed ?? 0.0;
//       }

//       _lastPosition = Position(
//         latitude: currentLocation.latitude!,
//         longitude: currentLocation.longitude!,
//         timestamp: DateTime.now(),
//       );

//       // Calculate calories burned (simple estimation)
//       double caloriesPerMeterWalking =
//           0.05; // Calories burned per meter for walking
//       double caloriesPerMeterRunning =
//           0.1; // Calories burned per meter for running

//       _totalCaloriesBurned = (_walkingDistance * caloriesPerMeterWalking) +
//           (_runningDistance * caloriesPerMeterRunning);
//     });

//     // Start listening to accelerometer to determine walking vs running
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       // We can adjust this based on step frequency or acceleration (simplified here)
//       if (event.x > 1.5 || event.y > 1.5 || event.z > 1.5) {
//         _isRunning = true; // Assume running when there's high acceleration
//       } else {
//         _isRunning = false; // Otherwise, assume walking
//       }
//     });
//   }

//   // Stop tracking when done
//   void stopTracking() {
//     _locationSubscription?.cancel();
//   }
// }
