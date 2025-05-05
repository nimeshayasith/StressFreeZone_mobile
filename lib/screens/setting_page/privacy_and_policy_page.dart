import 'package:flutter/material.dart';

class PrivacyAndPolicyPage extends StatelessWidget {
  const PrivacyAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
            SizedBox(height: 16),
            Text(
              "1. Data Collection",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "We collect personal data such as your name, email address, and app usage details to enhance your experience and provide personalized content.",
            ),
            SizedBox(height: 16),
            Text(
              "2. Data Usage",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your data is used to personalize the app, improve our services, and communicate with you about updates and offers.",
            ),
            SizedBox(height: 16),
            Text(
              "3. Data Sharing",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "We do not share your personal data with third parties except as required by law or with your consent.",
            ),
            SizedBox(height: 16),
            Text(
              "4. Data Security",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "We implement reasonable security measures to protect your data from unauthorized access, alteration, disclosure, or destruction.",
            ),
            SizedBox(height: 16),
            Text(
              "5. Your Rights",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "You have the right to access, correct, or delete your personal data. You can request these actions by contacting our support team.",
            ),
            SizedBox(height: 16),
            Text(
              "6. Changes to This Policy",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.",
            ),
            SizedBox(height: 16),
            Text(
              "7. Contact Us",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "For any questions or concerns regarding this privacy policy, please contact us at support_stressfreezone@gmail.com.",
            ),
          ],
        ),
      ),
    );
  }
}
