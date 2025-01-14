import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:flutter_application/services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const SignUpPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    // Initialize controllers here
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose of controllers to release resources
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // final String baseUrl =
  //     "https://stressfreezone-web.onrender.com"; // Replace with your backend URL
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        authService.signUpUser(
            context: context,
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            confirmpassword: _confirmPasswordController.text);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // try {
  //   final response = await http.post(
  //     Uri.parse(
  //         '$baseUrl/api/auth/signup'), // Replace with your endpoint path
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'name': _nameController.text,
  //       'email': _emailController.text,
  //       'password': _passwordController.text
  //     }),
  //   );

  // print("Response Status Code: ${response.statusCode}");
  // print("Response Body: ${response.body}");

  // if (response.statusCode == 200 || response.statusCode == 201) {
  // final data = jsonDecode(response.body);

  // // Save token locally
  // final prefs = await SharedPreferences.getInstance();
  // await prefs.setString('token', data['token']);

  // Print the token to check if it's created
// ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text("Registration successful!")),
//   );

  // if (mounted) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => LoginPage(
  //         isDarkMode: widget.isDarkMode,
  //         toggleTheme: widget.toggleTheme,
  //       ),
  //     ),
  //   );
  // }
  //     } else {
  //       // Handle server error response
  //       final error = jsonDecode(response.body)['msg'] ?? 'Signup failed';
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(error)),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error: $e")),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontFamily: 'Cabin'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1C0038),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cabin',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: registerUser,
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(vertical: 16.0)),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontFamily: 'Cabin'),
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                              isDarkMode: widget.isDarkMode,
                              toggleTheme: widget.toggleTheme),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Already have an account? Sign in',
                        style: TextStyle(fontFamily: 'Cabin')),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
