import 'package:flutter/material.dart';
import 'package:flutter_application/screens/questions/question5page.dart';
import 'package:flutter_application/screens/home_page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question4page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Question4page({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  Future<void> completeQuestions(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isQuestionCompleted', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Questionpage(
      question:
          "Do you set specific deadlines for tasks or rely on general reminders?",
      options: const ["Yes", "No"],
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");
      },
      onNextPressed: () {
        toggleTheme();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      isDarkMode: isDarkMode,
      toggleTheme: toggleTheme,
    );
  }
}
