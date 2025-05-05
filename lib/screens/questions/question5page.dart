import 'package:flutter/material.dart';
import 'questionpage.dart';
import 'question6page.dart';

class Question5page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Question5page({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Questionpage(
      question:
          "How much time are you willing to dedicate to stress management daily?",
      options: const [
        "5 - 10 minutes",
        "10 - 20 minutes",
        "20 - 30 minutes",
        "More than 30 minutes"
      ],
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");
      },
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Question6page(
                    isDarkMode: isDarkMode,
                    toggleTheme: toggleTheme,
                  )),
        );
      },
      isDarkMode: isDarkMode,
      toggleTheme: toggleTheme,
    );
  }
}
