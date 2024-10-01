import 'package:flutter/material.dart';
import 'package:flutter_application/login_page.dart';

class SuccessPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  const SuccessPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stress Free Zone',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
      ),
      backgroundColor: isDarkMode ? Colors.black : const Color(0xFF1C0038),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/success.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Success',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cabin',
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your password has been changed. From now on use your new password to login.',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Cabin',
                color: isDarkMode ? Colors.grey[300] : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                          isDarkMode: isDarkMode, toggleTheme: toggleTheme)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: isDarkMode ? Colors.green[800] : Colors.green,
              ),
              child: const Text(
                'OK',
                style: TextStyle(fontFamily: 'Cabin'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: toggleTheme,
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
              label: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
