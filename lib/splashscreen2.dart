import 'package:flutter/material.dart';
import 'splashscreen3.dart';

class Splashscreen2 extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Splashscreen2({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : const Color.fromARGB(255, 15, 206, 240),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: toggleTheme,
          ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splashpage2.png'),
            const SizedBox(height: 20),
            const Text(
              'RELAX MORE.',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cabin'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Unwind and find serenity in a guided meditation sessions',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Cabin'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Splashscreen3(
                          isDarkMode: isDarkMode, toggleTheme: toggleTheme)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontFamily: 'Cabin'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                'Sign in',
                style: TextStyle(fontFamily: 'Cabin'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
