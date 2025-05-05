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
                  "You can reset your password by going to the 'Reset Password' section in the app and following the instructions. A reset link will be sent to your registered email.",
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
                  "We offer programs for stress management, better sleep, focus boosters, and mindfulness. Check the 'Goals and Programs' section for detailed descriptions.",
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
                  "Yes, you can upgrade to premium by visiting the Subscription Management page in the app. Premium users have access to exclusive content and features.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("How can I contact customer support?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "You can contact customer support by emailing us at support_stressfreezone@gmail.com or through the 'Contact Us' section in the app.",
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("What should I do if I encounter a bug?"),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "If you encounter a bug, please report it to us via the 'Feedback' section in the app or email us at support_stressfreezone@gmail.com. Include details about the issue and your device information.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
