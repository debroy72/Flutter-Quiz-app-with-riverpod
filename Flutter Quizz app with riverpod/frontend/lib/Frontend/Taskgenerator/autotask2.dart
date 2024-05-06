import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SyllogismQuestion {
  final String premises;
  final String conclusion;
  final bool answer;

  SyllogismQuestion({
    required this.premises,
    required this.conclusion,
    required this.answer,
  });
}

class SyllogismTaskGenerator {
  final int numberOfQuestions;
  final List<SyllogismQuestion> questions = [];
  final Random random = Random();

  SyllogismTaskGenerator({required this.numberOfQuestions});

  void generate() {
    for (int i = 0; i < numberOfQuestions; i++) {
      bool p = random.nextBool();
      bool q = random.nextBool();
      String premises = "All men are mortal. Socrates is a man.";
      String conclusion = p
          ? "Therefore, Socrates is mortal."
          : "Therefore, Socrates is immortal.";
      bool answer = p;
      questions.add(SyllogismQuestion(
          premises: premises, conclusion: conclusion, answer: answer));
    }
  }

  List<SyllogismQuestion> getGeneratedQuestions() {
    return questions;
  }
}

class AutoTaskPage2 extends StatefulWidget {
  const AutoTaskPage2({Key? key}) : super(key: key);

  @override
  _AutoTaskPage2State createState() => _AutoTaskPage2State();
}

class _AutoTaskPage2State extends State<AutoTaskPage2> {
  late Future<List<SyllogismQuestion>> questionFuture;
  int currentQuestionIndex = 0;
  bool? selectedAnswer;

  @override
  void initState() {
    super.initState();

    questionFuture = generateQuestionsAsync();
  }

  Future<List<SyllogismQuestion>> generateQuestionsAsync() async {
    return await compute(generateSyllogismQuestions, 20);
  }

  static List<SyllogismQuestion> generateSyllogismQuestions(
      int numberOfQuestions) {
    SyllogismTaskGenerator generator =
        SyllogismTaskGenerator(numberOfQuestions: numberOfQuestions);
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
          actions: <Widget>[
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

  void checkAnswerAndContinue(List<SyllogismQuestion> questions) {
    if (selectedAnswer != null) {
      bool isCorrect = questions[currentQuestionIndex].answer == selectedAnswer;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isCorrect ? 'Correct!' : 'Incorrect.'),
      ));

      Future.delayed(const Duration(seconds: 1), () {
        nextQuestion(questions.length);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select an answer.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syllogism Logic Quiz'),
      ),
      body: FutureBuilder<List<SyllogismQuestion>>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<SyllogismQuestion> questions = snapshot.data!;
            SyllogismQuestion currentQuestion = questions[currentQuestionIndex];
            return buildQuestionPage(currentQuestion, questions);
          } else {
            return const Center(child: Text('No questions available.'));
          }
        },
      ),
    );
  }

  Widget buildQuestionPage(
      SyllogismQuestion currentQuestion, List<SyllogismQuestion> questions) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentQuestion.premises,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          Text(
            currentQuestion.conclusion,
            style: const TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
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
}

void main() {
  runApp(const MaterialApp(
    title: 'Syllogism Logic Quiz',
    home: AutoTaskPage2(),
  ));
}
