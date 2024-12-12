import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';
import 'package:flutter_application/questions/question1page.dart';

class LoginPage extends StatefulWidget {
  
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  LoginPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stress Free Zone',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              widget.toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor:
         widget.isDarkMode ? const Color.fromRGBO(59, 94, 132, 1.0) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cabin'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Use the same method that you created your account with.',
              style: TextStyle(
                  fontSize: 16.0, color: Colors.grey, fontFamily: 'Cabin'),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/loadingpage.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.apple, size: 24.0),
                    label: const Text(
                      'Continue with Apple',
                      style: TextStyle(fontFamily: 'Cabin'),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor:
                          widget.isDarkMode ? Colors.grey[850] : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: const Text(
                      'Continue with Google',
                      style: TextStyle(fontFamily: 'Cabin'),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor:
                          widget.isDarkMode ? Colors.grey[850] : Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Or sign in with email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                        fontFamily: 'Cabin'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                labelStyle:
                    TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
              style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                labelStyle:
                    TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
              ),
              obscureText: true,
              style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate the form...........................................................................
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Question1page(
                      isDarkMode: widget.isDarkMode,
                      toggleTheme: widget.toggleTheme,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontFamily: 'Cabin'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(
                              isDarkMode: widget.isDarkMode,
                              toggleTheme: widget.toggleTheme)),
                    );
                  },
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(fontFamily: 'Cabin'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpPage(
                              isDarkMode: widget.isDarkMode,
                              toggleTheme: widget.toggleTheme)),
                    );
                  },
                  child: const Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(fontFamily: 'Cabin'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
