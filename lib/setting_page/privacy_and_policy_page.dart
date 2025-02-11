import 'package:flutter/material.dart';

class PrivacyAndPolicyPage extends StatelessWidget {
  const PrivacyAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy and Policy'),
        backgroundColor: Colors.teal,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "1. Data Collection",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "We collect data such as your name, email, and app usage details to enhance your experience.",
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "2. Data Usage",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your data is used to personalize the app and provide better recommendations.",
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "3. Data Sharing",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "We do not share your data with third parties except as required by law.",
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "4. Your Rights",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "You can request data deletion or correction by contacting support.",
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "For more information, contact us at example@gmail.com.",
            ),
          ],
        ),
      ),
    );
  }
}
