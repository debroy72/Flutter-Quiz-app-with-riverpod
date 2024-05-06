import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generator/genrator/taskgenerator4.dart';

class AutoTaskPageInductive extends StatefulWidget {
  const AutoTaskPageInductive({Key? key}) : super(key: key);

  @override
  _AutoTaskPageInductiveState createState() => _AutoTaskPageInductiveState();
}

class _AutoTaskPageInductiveState extends State<AutoTaskPageInductive> {
  late Future<List<InductiveQuestion>> questionFuture;
  int currentQuestionIndex = 0;
  bool? selectedAnswer;

  @override
  void initState() {
    super.initState();
    questionFuture = generateQuestionsAsync();
  }

  Future<List<InductiveQuestion>> generateQuestionsAsync() async {
    return await compute(generateInductiveQuestions, 5);
  }

  static List<InductiveQuestion> generateInductiveQuestions(
      int numberOfQuestions) {
    InductiveTaskGenerator generator =
        InductiveTaskGenerator(numberOfQuestions: numberOfQuestions);
    generator.generate();
    return generator.getGeneratedQuestions();
  }

  void nextQuestion(int totalQuestions) {
    if (currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Quiz Completed"),
          content: const Text("You've reached the end of the quiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  currentQuestionIndex = 0;
                });
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      );
    }
  }

  void checkAnswerAndContinue(List<InductiveQuestion> questions) {
    if (selectedAnswer != null) {
      bool isCorrect = questions[currentQuestionIndex].answer == selectedAnswer;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isCorrect ? 'Correct!' : 'Incorrect.'),
        duration: const Duration(seconds: 2),
      ));

      Future.delayed(const Duration(seconds: 2), () {
        nextQuestion(questions.length);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select an answer.'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inductive Logic Quiz'),
      ),
      body: FutureBuilder<List<InductiveQuestion>>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<InductiveQuestion> questions = snapshot.data!;
            InductiveQuestion currentQuestion = questions[currentQuestionIndex];
            return buildQuestionPage(currentQuestion, questions);
          } else {
            return const Center(child: Text('No questions available.'));
          }
        },
      ),
    );
  }

  Widget buildQuestionPage(
      InductiveQuestion currentQuestion, List<InductiveQuestion> questions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentQuestion.question,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20.0),
          ListTile(
            title: const Text('True'),
            leading: Radio<bool>(
              value: true,
              groupValue: selectedAnswer,
              onChanged: (bool? value) {
                setState(() {
                  selectedAnswer = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('False'),
            leading: Radio<bool>(
              value: false,
              groupValue: selectedAnswer,
              onChanged: (bool? value) {
                setState(() {
                  selectedAnswer = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => checkAnswerAndContinue(questions),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void main() {
    runApp(const MaterialApp(
      title: 'Inductive Logic Quiz',
      home: AutoTaskPageInductive(),
    ));
  }
}
