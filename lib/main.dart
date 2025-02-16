import 'package:flutter/material.dart';
import 'package:flutter_application/discover_page/discover_page.dart';
import 'package:flutter_application/login_page/login_page.dart';
import 'package:flutter_application/tracker/movement_service.dart';
import 'package:flutter_application/tracker/tracker.dart';
//import 'login_page.dart';
//import 'splashscreen1.dart';
import 'splash_screen_page/loader_screen.dart';
import 'search_page/search_page.dart';
import 'search_page/calendar_page.dart';
import 'home_page/homepage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application/screens/home_page/content_provider.dart';
import 'package:flutter_application/screens/home_page/todo_provider.dart';
import 'package:flutter_application/screens/todo_list/todo_list_page.dart';
import 'package:flutter_application/screens/progress_page/progresspage.dart';
import 'package:flutter_application/screens/setting_page/setting_page.dart';
import 'package:flutter_application/providers/user_provider.dart'; // Add this import

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  final tracker = Tracker();
  MovementService(tracker); // Initialize MovementService

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => Tracker()),
        ChangeNotifierProvider(
          create: (context) {
            final todoProvider = ToDoProvider();
            todoProvider.initializePredefinedLists();
            return todoProvider;
          },
        ),
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Add UserProvider
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
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Stress Free Zone',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.isDarkMode
              ? ThemeData(
                  primaryColor: const Color(0xFF3B5E84),
                  scaffoldBackgroundColor: const Color(0xFF3B5E84),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Color(0xFF3B5E84),
                  ),
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Colors.white),
                    bodyMedium: TextStyle(color: Colors.white),
                  ),
                  brightness: Brightness.dark,
                )
              : ThemeData(
                  primaryColor: Colors.white,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.white,
                  ),
                  textTheme: const TextTheme(
                    bodyLarge: TextStyle(color: Colors.black),
                    bodyMedium: TextStyle(color: Colors.black),
                  ),
                  brightness: Brightness.light,
                ),
          home: LoaderScreen(
            isDarkMode: themeProvider.isDarkMode,
            toggleTheme: themeProvider.toggleTheme,
          ),
          routes: {
            '/home': (context) => const HomePage(),
            '/mainpage': (context) => const SearchPage(),
            '/calendarpage': (context) => const CalendarPage(),
            '/todoList': (context) => const TodoListPage(),
            '/discover': (context) => const DiscoverPage(),
            '/progress': (context) => const ProgressPage(),
            '/settings': (context) => const SettingPage(),
            '/login': (context) => LoginPage(
                  isDarkMode: themeProvider.isDarkMode,
                  toggleTheme: themeProvider.toggleTheme,
                ),
            '/splashscreen1': (context) => Splashscreen1(
                  isDarkMode: themeProvider.isDarkMode,
                  toggleTheme: themeProvider.toggleTheme,
                ),
          },
        );
      },
    );
  }
}

class AuthPage extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const AuthPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  Future<void> checkQuestionCompletion(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isQuestionCompleted = prefs.getBool('isQuestionCompleted') ?? false;

    if (!isQuestionCompleted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Question1page(
            isDarkMode: isDarkMode,
            toggleTheme: toggleTheme,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            checkQuestionCompletion(context);
          },
          child: const Text("Login"),
        ),
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
