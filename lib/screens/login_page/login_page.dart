import 'package:flutter/material.dart';
import 'package:flutter_application/screens/questions/question1page.dart';
import 'package:flutter_application/services/auth_services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signup_page.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const LoginPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  Future<void> login() async {
    // final email = _emailController.text.trim();
    // final password = _passwordController.text;
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  // if (email.isEmpty || password.isEmpty) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Please fill in all fields')),
  //   );
  //   return;
  // }

  // final url = Uri.parse(
  //     'https://stressfreezone-web.onrender.com/api/auth/login'); // Replace with your backend URL
  // final body = jsonEncode({'email': email, 'password': password});
  // final headers = {'Content-Type': 'application/json'};

  // try {
  //   final response = await http.post(url, body: body, headers: headers);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     // Save token using SharedPreferences for persistent storage
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('token', data['token']);

  //     // Optionally, store user details
  //     await prefs.setString('userName', data['user']['name']);
  //     await prefs.setString('userEmail', data['user']['email']);

  //     // Navigate to the next page
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Question1page(
  //           isDarkMode: widget.isDarkMode,
  //           toggleTheme: widget.toggleTheme,
  //         ),
  //       ),
  //     );
  //   } else {
  //     final error = jsonDecode(response.body)['msg'];
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(error)),
  //     );
  //   }
  // } catch (e) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //         content: Text('An error occurred. Please try again later.')),
  //   );
  //   print('Login Error: $e');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CALM MIND',
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
      backgroundColor: widget.isDarkMode
          ? const Color.fromRGBO(59, 94, 132, 1.0)
          : Colors.white,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.9, // Adjust opacity for better readability
              child: Image.asset(
                'assets/images/loginpage.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CALM MIND and Stress Free Zone text
                Column(
                  children: [
                    Text(
                      'CALM MIND',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cabin',
                        color: widget.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Stress Free Zone',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Cabin',
                        color: widget.isDarkMode ? Colors.white70 : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Buttons
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.apple, size: 24.0),
                  label: const Text(
                    'Continue with Apple',
                    style: TextStyle(fontFamily: 'Cabin'),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 80.0),
                    backgroundColor: widget.isDarkMode
                        ? Colors.grey[850]
                        : const Color.fromRGBO(29, 172, 146, 1.00),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(fontFamily: 'Cabin'),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 80.0),
                    backgroundColor: widget.isDarkMode
                        ? Colors.grey[850]
                        : const Color.fromRGBO(29, 172, 146, 1.00),
                  ),
                ),
                const SizedBox(height: 20),
                // Email sign-in text
                const Text(
                  'Or sign in with email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                    fontFamily: 'Cabin',
                  ),
                ),
                const SizedBox(height: 20),
                // Email Input
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black),
                  ),
                  style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 10),
                // Password Input
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    labelStyle: TextStyle(
                        color: widget.isDarkMode ? Colors.white : Colors.black),
                  ),
                  obscureText: true,
                  style: TextStyle(
                      color: widget.isDarkMode ? Colors.white : Colors.black),
                ),
                const SizedBox(height: 20),
                // Sign-In Button
                ElevatedButton(
                  onPressed: () async {
                    await login();
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
                    backgroundColor: const Color.fromRGBO(29, 172, 146, 1.00),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 80.0),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontFamily: 'Cabin'),
                  ),
                ),
                const SizedBox(height: 20),
                // Forgot Password and Sign-Up Options
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
                              toggleTheme: widget.toggleTheme,
                            ),
                          ),
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
                              toggleTheme: widget.toggleTheme,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(fontFamily: 'Cabin'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
