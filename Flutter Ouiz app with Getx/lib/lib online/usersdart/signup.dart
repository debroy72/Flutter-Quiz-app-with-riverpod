import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser() async {
    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:5001/register'), // Adjust with your backend endpoint
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Signup Successful'),
          content: const Text('You can now log in with your credentials.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Dismiss alert dialog
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      // Handle error or display message
      if (kDebugMode) {
        print('Failed to create user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
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
                  onPressed: () {
                    registerUser();
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ));
  }
}
