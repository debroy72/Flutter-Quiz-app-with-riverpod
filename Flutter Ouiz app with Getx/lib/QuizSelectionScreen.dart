import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/lib%20online/usersdart/loginpage.dart';
import 'package:myapp/welcome_screen.dart';
// Import the OnlineQuizPage

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
                // Navigate to the Offline Quiz Screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()));
              },
              child: const Text('Offline Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Online Quiz Screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const LoginPage())); // Assuming level 1 to start
              },
              child: const Text('Online Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
