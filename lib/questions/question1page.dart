import 'package:flutter/material.dart';
import 'questionpage.dart';
import 'question2page.dart';

class Question1page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Question1page({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Questionpage(
      question: "What would you like to achieve?",
      options: const ["Relax More", "Sleep Better", "Learn to Meditate"],
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");
      },
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Question2page(
                    isDarkMode: isDarkMode,
                    toggleTheme: toggleTheme,
                  )),
        );
      },isDarkMode: isDarkMode, toggleTheme: toggleTheme,
    );
  }
}
