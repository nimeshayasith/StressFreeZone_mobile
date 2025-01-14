import 'package:flutter/material.dart';
import 'package:flutter_application/screens/login_page/login_page.dart';
import 'package:flutter_application/main.dart';
import 'package:provider/provider.dart';

class Splashscreen4 extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Splashscreen4({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreen4State createState() => _SplashScreen4State();
}

class _SplashScreen4State extends State<Splashscreen4> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode
            ? const Color.fromRGBO(59, 94, 132, 1.0)
            : const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'CALM MIND',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
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
              'assets/images/splashpage4.png',
              width: 334,
              height: 458,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              'LIVE BETTER',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cabin'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Invest in personal sense of inner peace and balance',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Cabin'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
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
                "Begin",
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
