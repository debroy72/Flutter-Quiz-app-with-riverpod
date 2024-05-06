import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/lib%20online/quizscreenonline.dart';
import 'package:myapp/lib%20online/usersdart/admin/admin_login.dart';
import 'package:myapp/lib%20online/usersdart/signup.dart';

// Make sure to import the OnlineQuizPage properly

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5001/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Navigate to QuizPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => QuizScreen(
                username: _usernameController
                    .text)), // Assuming level 1 for simplicity
      );
    } else {
      // Optionally show an error message or navigate back to QuizSelectionScreen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
      Navigator.pop(context); // Go back to QuizSelectionScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assests/images/welcomebg.jpg'), // Replace with your actual background image path
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loginUser,
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: const Text('Sign Up'),
                ),
                // Add a new button here for Admin Login
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdminLogin()), // Use the AdminLogin widget
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue, // Button background color
                  ),
                  child: const Text('Admin Login'),
                )
              ],
            ),
          ),
        ));
  }
}
