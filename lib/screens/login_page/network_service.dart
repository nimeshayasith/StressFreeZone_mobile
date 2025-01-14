import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NetworkService {
  final String baseUrl = "https://stressfreezone-web.onrender.com";
  final _storage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Save JWT token to secure storage
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  // Retrieve JWT token from secure storage
  Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Clear JWT token from secure storage
  Future<void> clearToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  Future<void> signup(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http:https://stressfreezone-web.onrender.com/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Save the token in secure storage
      await _storage.write(key: 'authToken', value: token);
    } else {
      throw Exception('Sign-up failed');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://<your-backend-url>/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      // Save the token in secure storage
      await _storage.write(key: 'authToken', value: token);
    } else {
      throw Exception('Login failed');
    }
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('http://<your-backend-url>/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      print('Reset link sent to email');
    } else {
      throw Exception('Failed to send reset link');
    }
  }

/*Future<void> resetPassword(String token, String newPassword) async {
  final response = await http.post(
    Uri.parse('http://<your-backend-url>/reset-password'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'token': token, // The token sent in the email
      'password': newPassword,
    }),
  );

  if (response.statusCode == 200) {
    print('Password reset successfully');
  } else {
    throw Exception('Failed to reset password');
  }
}
*/

  // Google Sign-In
  Future<Map<String, dynamic>> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return {'error': true, 'message': 'Google Sign-In cancelled.'};
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Send the ID token to the backend
      final response = await http.post(
        Uri.parse("$baseUrl/api/auth/google"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'idToken': googleAuth.idToken,
        }),
      );

      if (response.statusCode == 200) {
        // Save the JWT token returned by the backend
        final token = jsonDecode(response.body)['token'];
        if (token != null) {
          await saveToken(token);
        }
        return {'success': true};
      } else {
        return {'error': true, 'message': jsonDecode(response.body)['message']};
      }
    } catch (e) {
      return {'error': true, 'message': e.toString()};
    }
  }

  // Logout Google Account
  Future<void> logoutGoogle() async {
    await _googleSignIn.signOut();
    await clearToken();
  }

  post(String s, Map<String, String> map) {}
}
