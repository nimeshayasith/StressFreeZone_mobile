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
            Text(
                "By downloading, installing, or using the app, you agree to these terms and conditions. If you do not agree, do not use the app."),
            SizedBox(height: 16),
            Text("2. License", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "We grant you a non-exclusive, non-transferable license to use the app for personal, non-commercial use."),
            SizedBox(height: 16),
            Text("3. User Account",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "You may need to create an account to access certain features. You are responsible for maintaining the confidentiality of your account information."),
            SizedBox(height: 16),
            Text("4. Use of the App",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "You agree to use the app only for lawful purposes and in accordance with these terms."),
            SizedBox(height: 16),
            Text("5. Termination",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "We reserve the right to terminate or suspend your access to the app at any time, without prior notice, for conduct that we believe violates these terms."),
            SizedBox(height: 16),
            Text("6. Limitation of Liability",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "In no event shall we be liable for any indirect, incidental, or consequential damages arising from your use of the app."),
            SizedBox(height: 16),
            Text("7. Changes to Terms",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "We may update these terms from time to time. We will notify you of any changes by posting the new terms on this page."),
            SizedBox(height: 16),
            Text("8. Contact Us",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "If you have any questions about these terms, please contact us at support_stressfreezone@gmail.com."),
          ],
        ),
      ),
    );
  }
}
