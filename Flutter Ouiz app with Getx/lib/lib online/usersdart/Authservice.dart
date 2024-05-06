import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/lib%20online/usersdart/usermodel.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:5001';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body);
      return User.fromJson(userData);
    } else {
      if (kDebugMode) {
        print('Login failed: ${response.body}');
      }
      return null;
    }
  }

  Future<User?> signup(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 201) {
      final userData = jsonDecode(response.body);
      return User.fromJson(userData);
    } else {
      if (kDebugMode) {
        print('Signup failed: ${response.body}');
      }
      return null;
    }
  }

  Future<void> logout() async {
    // Implement your logout logic here
    // For example, clearing shared preferences or secure storage
  }
}
