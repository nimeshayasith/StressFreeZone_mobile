import 'package:flutter/material.dart';
import 'questionpage.dart';
import 'question3page.dart';

class Question2page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  const Question2page({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Questionpage(
      question: "Do you experience any of following?",
      options: const [
        "Restless",
        "Anxiety",
        "Difficult to Concentrate",
        "Difficulty falling asleep"
      ],
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");
      },
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Question3page(
                    isDarkMode: isDarkMode,
                    toggleTheme: toggleTheme,
                  )),
        );
      },isDarkMode: isDarkMode, toggleTheme: toggleTheme,
    );
  }
}
