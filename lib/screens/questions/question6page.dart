import 'package:flutter/material.dart';
import 'package:flutter_application/main.dart';
import 'package:provider/provider.dart';
import 'questionpage.dart';
import 'package:flutter_application/screens/home_page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question6page extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const Question6page({
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
      "Guided meditation",
      "Breathing exercises",
      "Yoga or stretching",
      "Soundscapes or Music therapy",
      "Visual Relaxation (e.g. nature scenes)",
      "Others (Please specify)"
    ];

    return Questionpage(
      question:
          "Which relaxation techniques are you most interested in? (Select all that apply)",
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
