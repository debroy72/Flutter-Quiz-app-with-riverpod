import 'package:flutter/material.dart';
import 'package:frontend/Frontend/Offlinequizz/UserGuideScreen.dart';

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

    if (username == "asdfgh" && password == "asdfgh") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const UserGuideScreen()),
      );
    } else {
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assests/images/welcomebg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
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
              ),
              // Text note at the bottom
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Default Login: asdfgh, Password: asdfgh',
                  style: TextStyle(
                    color: Color.fromARGB(255, 14, 13, 13).withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
