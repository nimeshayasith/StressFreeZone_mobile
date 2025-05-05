import 'package:flutter/material.dart';
import 'package:flutter_application/screens/questions/question5page.dart';
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
      question: "Which of these relaxation techniques have you tried before?",
      options: const [
        "Deep Breathing Exercises",
        "Mindfullness Meditation",
        "Movements Exercises",
        "Listening to Music",
        "Guided Imagery",
        "None of the above"
      ],
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");
      },
      onNextPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Question4page(
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
