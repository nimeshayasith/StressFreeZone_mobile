//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(
//           0xFF1A3C5E), // Updated background color to match the image
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Centered image section
//             Image.asset(
//               'assets/images/loginpage.png',
//               width: MediaQuery.of(context).size.width * 0.6,
//               height: MediaQuery.of(context).size.height * 0.3,
//             ),
//             const SizedBox(height: 20),
//             // Title and subtitle
//             const Text(
//               'CALM MIND',
//               style: TextStyle(
//                 fontSize: 28.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 fontFamily: 'Cabin',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const Text(
//               'Stress free zone',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 color: Colors.white70,
//                 fontFamily: 'Cabin',
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30),
//             // Buttons for sign-in options
//             ElevatedButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.apple, size: 24.0),
//               label: const Text('Continue with Apple',
//                   style: TextStyle(fontFamily: 'Cabin')),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 backgroundColor: Colors.black,
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {},
//               icon: const FaIcon(FontAwesomeIcons.google, size: 20.0),
//               label: const Text('Continue with Google',
//                   style: TextStyle(fontFamily: 'Cabin')),
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Sign In with Email',
//               style: TextStyle(
//                 fontSize: 18.0,
//                 color: Colors.white70,
//                 fontFamily: 'Cabin',
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () async {
//                 await login();
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => Question1page(
//                       isDarkMode: widget.isDarkMode,
//                       toggleTheme: widget.toggleTheme,
//                     ),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromRGBO(29, 172, 146, 1.0),
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text(
//                 'Sign In with Email',
//                 style: TextStyle(fontFamily: 'Cabin', color: Colors.white),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ForgotPasswordPage(
//                             isDarkMode: widget.isDarkMode,
//                             toggleTheme: widget.toggleTheme),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Forgot password?',
//                     style: TextStyle(
//                       fontFamily: 'Cabin',
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 120),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SignUpPage(
//                             isDarkMode: widget.isDarkMode,
//                             toggleTheme: widget.toggleTheme),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     'Sign Up',
//                     style:
//                         TextStyle(fontFamily: 'Cabin', color: Colors.white70),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
