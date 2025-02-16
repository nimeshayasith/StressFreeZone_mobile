import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:provider/provider.dart';
import 'questionpage.dart';
import 'package:flutter_application/home_page/homepage.dart';
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final List<String> timeRanges = [
      'Less than 30 minutes',
      '30 minutes - 1 hour',
      '1 hour - 1 hour and & 30 minutes',
      '1 hour and 30 minutes - 2 hours',
      '2 hours - 2 hours & 30 minutes',
      '2 hours & 30 minutes - 3 hours',
      'More than 3 hours'
    ];

    return Questionpage(
      question: "How many mindful minutes would you like to have in a day?",
      options: timeRanges,
      onOptionSelected: (int selectedOption) {
        //print("Selected option: $selectedOption");
        debugPrint("Navigating to HomePage");
      },
      onNextPressed: () {
        themeProvider.setDarkMode(themeProvider.isDarkMode);
        completeQuestions(context);
      },
      isDarkMode: themeProvider.isDarkMode,
      toggleTheme: themeProvider.toggleTheme,
    );
  }
}
