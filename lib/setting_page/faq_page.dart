import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ExpansionTile(
            title: Text("How do I reset my password?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You can reset your password by going to the 'Reset Password' section in the app and following the instructions.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("What programs do you offer?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "We offer programs for stress management, better sleep, and focus boosters. Check the 'Goals and Programs' section for details.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Is there a premium version available?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Yes, you can upgrade to premium by visiting the Subcription Management page in the app.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
