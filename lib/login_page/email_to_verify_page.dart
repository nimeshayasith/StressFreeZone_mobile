import 'package:flutter/material.dart';
import 'package:flutter_application/login_page/success_page.dart';
//import 'success_page.dart';

class EmailToVerifyPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  EmailToVerifyPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify your email',
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
              'We\'re going to send you an email with a login link.',
              style: TextStyle(fontSize: 18.0, fontFamily: 'Cabin'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please enter your email address below.',
              style: TextStyle(fontSize: 16.0, fontFamily: 'Cabin'),
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
                      builder: (context) => SuccessPage(
                          isDarkMode: isDarkMode, toggleTheme: toggleTheme)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Center(
                  child: Text(
                'Verify',
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
