import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Offlinequizz/TaskGeneratorQuizSelectionPage.dart';
import 'package:frontend/Frontend/Offlinequizz/welcome_screen.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/loginpage.dart';

class QuizSelectionScreen extends ConsumerWidget {
  const QuizSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Selection'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/images/quizzselectionbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                );
              },
              child: const Text('Offline Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Online Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const autoQuizSelectionPage()),
                );
              },
              child: const Text('Auto-Generated Logic Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
