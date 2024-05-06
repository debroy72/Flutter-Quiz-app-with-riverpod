import 'package:flutter/material.dart';
import 'package:myapp/UserGuideScreen.dart';
// Adjust the import path to your QuizPage

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Check if the credentials match the test user
    if (username == "asdfgh" && password == "asdfgh") {
      // Navigate to the QuizPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserGuideScreen()),
      );
    } else {
      // Show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Welcome")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assests/images/welcomebg.jpg"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
