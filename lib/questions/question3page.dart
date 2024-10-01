import 'package:flutter/material.dart';
import 'questionpage.dart';
import 'question4page.dart';

class Question3page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Question3page({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Questionpage(
      question: "Do you have experience with meditation?",
      options: const ["Yes", "No", "A bit"],
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Question4page(
                    isDarkMode: isDarkMode,
                    toggleTheme: toggleTheme,
                  )),
        );
      },
    );
  }
}
