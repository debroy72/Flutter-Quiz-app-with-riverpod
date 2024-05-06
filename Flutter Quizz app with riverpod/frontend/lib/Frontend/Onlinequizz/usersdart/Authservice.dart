import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/usermodel.dart';
import 'package:http/http.dart' as http;

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

  Future<void> logout() async {}
}
