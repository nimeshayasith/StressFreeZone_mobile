import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text("1. Acceptance of Terms",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("By downloading, installing..."),
            SizedBox(
              height: 16,
            ),
            Text("2. License", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("We grant you a non-exclusive..."),
            SizedBox(
              height: 16,
            ),
            Text("3. User Account",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Some features of the App..."),
            SizedBox(
              height: 16,
            ),
            Text("4. Use of the App",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text("You agree to use the app only for lawful purposes..."),
          ],
        ),
      ),
    );
  }
}
