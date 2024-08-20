import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const ForgotPasswordPage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailSent = false;
  bool _isEmailValid = true;

  void _sendEmail() {
    setState(() {
      String email = _emailController.text;
      if (_validateEmail(email)) {
        _isEmailSent = true;
        _isEmailValid = true;
      } else {
        _isEmailValid = false;
        _isEmailSent = false;
      }
    });
  }

  bool _validateEmail(String email) {
    return email.contains('@');
  }

  void _resendEmail() {
    setState(() {});
  }

  void _resetEmailInput() {
    setState(() {
      _isEmailSent = false;
      _isEmailValid = true;
      _emailController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Please enter an email address that you used to create account with so we can send you an email to reset your password.',
                style: TextStyle(fontSize: 16.0, fontFamily: 'Cabin')),
            const SizedBox(height: 20.0),
            const Text('Email',
                style: TextStyle(fontSize: 16.0, fontFamily: 'Cabin')),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: const OutlineInputBorder(),
                errorText: _isEmailValid
                    ? null
                    : 'Please enter the correct email that you used to login',
              ),
              enabled: !_isEmailSent,
            ),
            const SizedBox(height: 20),
            _isEmailSent
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please check your email inbox for the confirmation.',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.green,
                            fontFamily: 'Cabin'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: _resendEmail,
                        child: const Text(
                          'Didn\'t receive the code? Resend',
                          style: TextStyle(fontFamily: 'Cabin'),
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    onPressed: _sendEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Center(
                        child: Text(
                      'Send email',
                      style: TextStyle(fontFamily: 'Cabin'),
                    )),
                  ),
            _isEmailValid == false
                ? TextButton(
                    onPressed: _resetEmailInput,
                    child: const Text(
                      'Enter email again',
                      style: TextStyle(fontFamily: 'Cabin'),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
