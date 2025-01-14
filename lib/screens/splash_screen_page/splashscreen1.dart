import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_application/login_page.dart';
import 'splashscreen2.dart';

class Splashscreen1 extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Splashscreen1({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreen1State createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<Splashscreen1> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromRGBO(59, 94, 132, 1.0)
            : const Color.fromRGBO(255, 255, 255, 1.0),
        title: const Text(
          'CALM MIND',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () => themeProvider.toggleTheme(),
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
              'assets/images/image239.png',
              width: 334,
              height: 458,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              'STRESS LESS.',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Cabin'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Make mindfulness a daily habit and be kind to your mind',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Cabin',
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Splashscreen2(
                          isDarkMode: themeProvider.isDarkMode,
                          toggleTheme: themeProvider.toggleTheme)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 160, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color.fromRGBO(29, 172, 146, 1.0),
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
