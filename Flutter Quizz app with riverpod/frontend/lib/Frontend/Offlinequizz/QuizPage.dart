import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Offlinequizz/Option.dart';
import 'package:frontend/Frontend/Offlinequizz/level_progression_handler.dart';
import 'package:frontend/Frontend/Offlinequizz/quiz_model.dart';
import 'package:frontend/Frontend/Offlinequizz/quiz_state_manager.dart';
import 'package:frontend/Frontend/Offlinequizz/sample_data.dart';
import 'package:frontend/Frontend/Offlinequizz/timer_controller.dart';

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
  int correctAnswersCount = 0;

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
      _timerController.startTimer();
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
      correctAnswersCount = 0;
    });
    _timerController.startTimer();
  }

  void showQuizCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Quiz Completed!"),
          content: const Text("Congratulations on completing the entire quiz!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                resetQuizForRetry();

                Navigator.of(context).pop();

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
      currentQuestionIndex = 0;
      correctAnswersCount = 0;
      selectedOptionIndex = null;
      isCorrect = null;
    });
    _timerController.reset();

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
              image: AssetImage("assests/images/quizzbg.jpg"),
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
