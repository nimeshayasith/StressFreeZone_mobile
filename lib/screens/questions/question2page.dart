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
      question: "How often do you experience stress related to these sources?",
      options: const [
        "Daily",
        "A few times a week",
        "Weekly",
        "Monthly",
        "Rarely"
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
      },
      isDarkMode: isDarkMode,
      toggleTheme: toggleTheme,
    );
  }
}
