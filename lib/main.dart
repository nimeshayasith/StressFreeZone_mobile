import 'package:flutter/material.dart';
import 'package:flutter_application/screens/discover_page/discover_page.dart';
import 'package:flutter_application/screens/login_page/login_page.dart';
//import 'login_page.dart';
//import 'splashscreen1.dart';
import 'screens/splash_screen_page/loader_screen.dart';
import 'screens/search_page/search_page.dart';
import 'screens/search_page/calendar_page.dart';
import 'screens/home_page/homepage.dart';
import 'package:provider/provider.dart';
import 'screens/home_page/content_provider.dart';
import 'screens/home_page/todo_provider.dart';
import 'screens/todo_list/todo_list_page.dart';
import 'screens/progress_page/progresspage.dart';
import 'screens/setting_page/setting_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContentProvider()),
        ChangeNotifierProvider(create: (_) => ToDoProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
  bool isDarkMode = true;
  /* int _selectedIndex = 0;
  

  final List<widget> _pages = [
    const HomePage(),
    const DiscoverPage(),
    const SearchPage(),
    const CalendarPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Stress Free Zone',
          debugShowCheckedModeBanner: false,
          theme:
              themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: LoaderScreen(
            isDarkMode: themeProvider.isDarkMode,
            toggleTheme: themeProvider.toggleTheme,
          ),
          //initialRoute: '/home',
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
          },
        );
      },
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
/*void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }
}*/
