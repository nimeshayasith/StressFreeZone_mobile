import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoaderScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const LoaderScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the home screen after a delay
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/splashscreen1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered Text
            Text(
              'Keep calm and Relax Mind',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 30), // Space between text and animation
            // Bouncing Ball Loading Animation
            LoadingAnimationWidget.bouncingBall(
              size: 100, // Size of the bouncing ball area
              color:
                  widget.isDarkMode ? Colors.white : Colors.blue, // Ball color
            ),
          ],
        ),
      ),
    );
  }
}
