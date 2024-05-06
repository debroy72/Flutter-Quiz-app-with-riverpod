import 'package:flutter/material.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/admin/admin_dashboard.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _adminController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    final adminUsername = _adminController.text;
    final adminPassword = _passwordController.text;
    if (adminUsername == 'Admin' && adminPassword == '12345678') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const AdminDashboard(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _adminController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
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
    );
  }
}
