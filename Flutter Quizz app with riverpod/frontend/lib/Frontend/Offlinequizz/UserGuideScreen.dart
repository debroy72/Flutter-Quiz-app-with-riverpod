import 'package:flutter/material.dart';
import 'package:frontend/Frontend/Offlinequizz/QuizPage.dart';
import 'package:frontend/Frontend/Offlinequizz/quizpagewithouttimer.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Guide'),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assests/images/userguidbg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to the Quiz App!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'How to Play:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '1. Read through the questions carefully.\n'
                    '2. Select your answer from the given options.\n'
                    '3. Complete all levels to finish the quiz.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assests/images/cattoguide.jpg',
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const QuizPage()),
                      ),
                      child: const Text('Start Quiz With Timer'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => const QuizPageWithoutTimer()),
                      ),
                      child: const Text('Start Quiz Without Timer'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
