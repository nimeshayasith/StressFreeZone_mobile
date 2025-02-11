import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:provider/provider.dart';
import 'splashscreen3.dart';

class Splashscreen2 extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Splashscreen2({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<Splashscreen2> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromRGBO(59, 94, 132, 1.0)
            : const Color.fromARGB(255, 15, 206, 240),
        title: const Text(
          'Stress Free Zone',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor: themeProvider.isDarkMode
          ? const Color.fromRGBO(59, 94, 132, 1.0)
          : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splashpage2.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              fit: BoxFit.contain,
            ),
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
                          isDarkMode: themeProvider.isDarkMode,
                          toggleTheme: themeProvider.toggleTheme)),
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
