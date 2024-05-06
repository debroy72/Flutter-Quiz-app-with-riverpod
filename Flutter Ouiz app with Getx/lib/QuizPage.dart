import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/Option.dart';
// Ensure this points to your actual OptionWidget file
import 'package:myapp/level_progression_handler.dart';
// Your level progression utility
import 'package:myapp/quiz_model.dart'; // Your quiz model
import 'package:myapp/quiz_state_manager.dart'; // Your quiz state manager
import 'package:myapp/sample_data.dart'; // Your sample data
import 'package:myapp/timer_controller.dart'; // Your timer controller

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  int currentQuestionIndex = 0;
  late TimerController _timerController;
  int? selectedOptionIndex;
  bool? isCorrect;
  int correctAnswersCount = 0; // Tracks the number of correct answers

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(
      duration: 20,
      onTick: (isDone) {
        if (isDone) {
          handleTimerExpiration();
        }
      },
    );
    _timerController.startTimer();
  }

  void handleTimerExpiration() {
    // Placeholder for additional logic you might want on timer expiration
    goToNextQuestion(false);
  }

  void goToNextQuestion(bool isAnswerCorrect) {
    if (isAnswerCorrect) correctAnswersCount++;

    if (currentQuestionIndex <
        levels[ref.read(quizProvider).currentLevelIndex].questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isCorrect = null;
      });
      _timerController.startTimer(); // Restart the timer for the next question
    } else {
      LevelProgressionUtil.checkAndHandleLevelCompletion(
        context: context,
        ref: ref,
        currentQuestionIndex: currentQuestionIndex,
        currentLevelIndex: ref.read(quizProvider).currentLevelIndex,
        correctAnswersCount: correctAnswersCount,
        onLevelComplete: resetForNextLevel,
        onQuizComplete: showQuizCompletionDialog,
        onLevelFail: resetQuizForRetry,
      );
    }
  }

  Future<void> resetForNextLevel() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      currentQuestionIndex = 0;
      selectedOptionIndex = null;
      isCorrect = null;
      correctAnswersCount = 0; // Reset correct answers count for the new level
    });
    _timerController.startTimer(); // Restart the timer for the new level
  }

  void showQuizCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quiz Completed!"),
          content: const Text("Congratulations on completing the entire quiz!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Reset the quiz state to the beginning
                resetQuizForRetry();
                // Pop the dialog off the stack
                Navigator.of(context).pop();
                // Then pop back to the Quiz Selection Screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void resetQuizForRetry() {
    setState(() {
      currentQuestionIndex = 0; // Reset to the first question
      correctAnswersCount = 0; // Reset the count of correct answers
      selectedOptionIndex = null; // Clear any selected option
      isCorrect = null; // Reset correctness
    });
    _timerController.reset();

    // Reset the global quiz state
    ref.read(quizProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final currentLevelIndex = quizState.currentLevelIndex;
    final Question question =
        levels[currentLevelIndex].questions[currentQuestionIndex];

    return Scaffold(
        appBar: AppBar(title: const Text("Quiz App")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assests/images/quizzbg.jpg"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: _timerController.progress,
                backgroundColor: Colors.grey[200],
                valueColor:
                    AlwaysStoppedAnimation(Theme.of(context).primaryColor),
              ),
              const SizedBox(height: 20),
              Text('Level ${currentLevelIndex + 1}',
                  style: Theme.of(context).textTheme.headline5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(question.questionText,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center),
              ),
              ...question.options.asMap().entries.map((entry) {
                int idx = entry.key;
                String optionText = entry.value;
                return OptionWidget(
                  optionText: optionText,
                  index: idx,
                  selectedOptionIndex: selectedOptionIndex,
                  isCorrect: isCorrect,
                  onSelectOption: (int index) {
                    setState(() {
                      selectedOptionIndex = index;
                      isCorrect = question.answerIndex == index;
                    });
                    Future.delayed(const Duration(seconds: 2),
                        () => goToNextQuestion(question.answerIndex == index));
                  },
                );
              }).toList(),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _timerController.stopTimer();
    super.dispose;
  }
}
