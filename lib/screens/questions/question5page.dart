import 'package:flutter/material.dart';
import 'question6page.dart';
// Ensure this file contains the definition of Questionpage

// If 'Questionpage' is not defined in 'questionpage.dart', define it here:
class Questionpage extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function(int) onOptionSelected;
  final VoidCallback onNextPressed;
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Questionpage({
    super.key,
    required this.question,
    required this.options,
    required this.onOptionSelected,
    required this.onNextPressed,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Page'),
      ),
      body: Column(
        children: [
          Text(question),
          ...options.asMap().entries.map((entry) {
            int idx = entry.key;
            String option = entry.value;
            return ListTile(
              title: Text(option),
              onTap: () => onOptionSelected(idx),
            );
          }).toList(),
          ElevatedButton(
            onPressed: onNextPressed,
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

// If Questionpage is not defined in 'questionpage.dart', define it here or import the correct file.

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
