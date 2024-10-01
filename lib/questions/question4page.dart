import 'package:flutter/material.dart';
import 'questionpage.dart';
import 'package:flutter_application/login_page.dart';

class Question4page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Question4page({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Questionpage(
      question: "How many mindful minutes would you like to have in a day?",
      options: List.generate(180, (index) => (index + 1).toString()),
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(
                    isDarkMode: isDarkMode,
                    toggleTheme: toggleTheme,
                  )),
        );
      },
    );
  }
}
