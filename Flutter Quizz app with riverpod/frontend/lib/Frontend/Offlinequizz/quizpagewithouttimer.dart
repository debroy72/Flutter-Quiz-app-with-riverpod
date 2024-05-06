import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Offlinequizz/OptionWidgetoffline.dart';
import 'package:frontend/Frontend/Offlinequizz/quiz_model.dart';
import 'package:frontend/Frontend/Offlinequizz/sample_data_withoutcounter.dart';

class QuizPageWithoutTimer extends ConsumerStatefulWidget {
  const QuizPageWithoutTimer({Key? key}) : super(key: key);

  @override
  _QuizPageWithoutTimerState createState() => _QuizPageWithoutTimerState();
}

class _QuizPageWithoutTimerState extends ConsumerState<QuizPageWithoutTimer> {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool? lastAnswerWasCorrect;
  int correctAnswersCount = 0;

  void goToNextQuestion() {
    bool isAnswerCorrect = selectedOptionIndex != null &&
        levels[0].questions[currentQuestionIndex].answerIndex ==
            selectedOptionIndex;

    if (isAnswerCorrect) {
      correctAnswersCount++;
    }

    setState(() {
      lastAnswerWasCorrect = isAnswerCorrect;
      if (currentQuestionIndex < levels[0].questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;
      } else {
        showCompletionDialog();
      }
    });
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Text(
            'You have completed the quiz with $correctAnswersCount correct answers.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetQuizForRetry();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void resetQuizForRetry() {
    setState(() {
      currentQuestionIndex = 0;
      selectedOptionIndex = null;
      lastAnswerWasCorrect = null;
      correctAnswersCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Question question = levels[0].questions[currentQuestionIndex];

    return Scaffold(
        appBar: AppBar(title: const Text("Offline Quiz Without Timer")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assests/images/quizzbg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      question.questionText,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ...List.generate(question.options.length, (index) {
                    return OptionWidgetoffline(
                      optionText: question.options[index],
                      index: index,
                      selectedOptionIndex: selectedOptionIndex,
                      isCorrect: selectedOptionIndex == index
                          ? lastAnswerWasCorrect
                          : null,
                      onSelectOption: (int selectedIndex) {
                        setState(() {
                          selectedOptionIndex = selectedIndex;
                          lastAnswerWasCorrect =
                              question.answerIndex == selectedIndex;
                        });

                        Future.delayed(const Duration(milliseconds: 500), () {
                          goToNextQuestion();
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
