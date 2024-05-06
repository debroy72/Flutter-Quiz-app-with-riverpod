import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generator/genrator/taskgenerator5.dart';

class AutoTaskPagePattern extends StatefulWidget {
  const AutoTaskPagePattern({Key? key}) : super(key: key);

  @override
  _AutoTaskPagePatternState createState() => _AutoTaskPagePatternState();
}

class _AutoTaskPagePatternState extends State<AutoTaskPagePattern> {
  late Future<List<PatternQuestion>> questionFuture;
  int currentQuestionIndex = 0;
  bool? selectedAnswer;

  @override
  void initState() {
    super.initState();

    questionFuture = generateQuestionsAsync();
  }

  Future<List<PatternQuestion>> generateQuestionsAsync() async {
    return await compute(generatePatternQuestions, 20);
  }

  static List<PatternQuestion> generatePatternQuestions(int numberOfQuestions) {
    PatternTaskGenerator generator =
        PatternTaskGenerator(numberOfQuestions: numberOfQuestions);
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
                  selectedAnswer = null;
                });
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      );
    }
  }

  void checkAnswerAndContinue(List<PatternQuestion> questions) {
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
        title: const Text('Pattern Logic Quiz'),
      ),
      body: FutureBuilder<List<PatternQuestion>>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<PatternQuestion> questions = snapshot.data!;
            PatternQuestion currentQuestion = questions[currentQuestionIndex];
            return buildQuestionPage(currentQuestion, questions);
          } else {
            return const Center(child: Text('No questions available.'));
          }
        },
      ),
    );
  }

  Widget buildQuestionPage(
      PatternQuestion currentQuestion, List<PatternQuestion> questions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sequence: ${currentQuestion.sequence}",
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20.0),
          Text("Next element: ${currentQuestion.nextElement}",
              style:
                  const TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic)),
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
                  })),
          ListTile(
              title: const Text('False'),
              leading: Radio<bool>(
                  value: false,
                  groupValue: selectedAnswer,
                  onChanged: (bool? value) {
                    setState(() {
                      selectedAnswer = value;
                    });
                  })),
          ElevatedButton(
              onPressed: () => checkAnswerAndContinue(questions),
              child: const Text('Next')),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Pattern Logic Quiz',
    home: AutoTaskPagePattern(),
  ));
}
