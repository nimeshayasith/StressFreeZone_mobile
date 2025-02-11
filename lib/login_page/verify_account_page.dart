// ignore: file_names

import 'package:flutter/material.dart';
import 'email_to_verify_page.dart';

class VerifyAccountPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  VerifyAccountPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify your Account',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: toggleTheme,
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1C0038),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email to verify your account',
              style: TextStyle(fontSize: 18.0, fontFamily: 'Cabin'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmailToVerifyPage(
                          isDarkMode: isDarkMode, toggleTheme: toggleTheme)),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.green,
              ),
              child: const Center(
                  child: Text(
                'Continue',
                style: TextStyle(fontFamily: 'Cabin'),
              )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
