import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // If you're using Riverpod for state management
import 'package:myapp/QuizSelectionScreen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizSelectionScreen(), // Set WelcomeScreen as the home screen
    );
  }
}
