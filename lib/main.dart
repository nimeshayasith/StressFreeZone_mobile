import 'package:flutter/material.dart';
//import 'login_page.dart';
//import 'splashscreen1.dart';
import 'loader_screen.dart';
import 'search_page/search_page.dart';
import 'search_page/calendar_page.dart';
import 'home_page/homepage.dart';
import 'package:provider/provider.dart';
import 'home_page/content_provider.dart';
import 'home_page/todo_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      home: LoaderScreen(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/mainpage': (context) => const SearchPage(),
        '/calendarpage': (context) => const CalendarPage(),
      },
    );
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}
