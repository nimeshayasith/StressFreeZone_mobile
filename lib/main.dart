import 'package:flutter/material.dart';
//import 'login_page.dart';
import 'splashscreen1.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stress Free Zone',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Splashscreen1(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
    );
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}
