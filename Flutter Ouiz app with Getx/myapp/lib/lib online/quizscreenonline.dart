import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Ensure this is correctly pointing to your OptionWidget file
import 'package:myapp/lib%20online/TimerController.dart';
import 'package:myapp/lib%20online/optionwidget.dart';
import 'package:myapp/lib%20online/provider.dart';

class OnlineQuizPage extends ConsumerStatefulWidget {
  final int level;
  const OnlineQuizPage({Key? key, required this.level}) : super(key: key);

  @override
  _OnlineQuizPageState createState() => _OnlineQuizPageState();
}

class _OnlineQuizPageState extends ConsumerState<OnlineQuizPage> {
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  late TimerController _timerController;
  int correctAnswersCount = 0; // Tracks correct answers

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(duration: 10, onTick: handleTimerTick);
    _timerController.startTimer();
  }

  void handleTimerTick(bool isDone) {
    if (isDone) {
      goToNextQuestion(false); // Assume time ran out without an answer
    }
  }

  void goToNextQuestion(bool isAnswerCorrect) {
    ref.watch(questionsProvider(widget.level)).whenData((questions) {
      if (isAnswerCorrect) {
        correctAnswersCount++;
      }

      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedOptionIndex = null;
        });
        _timerController.reset();
      } else {
        showCompletionDialog();
      }
    });
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('You answered $correctAnswersCount questions correctly.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsyncValue = ref.watch(questionsProvider(widget.level));

    return Scaffold(
      appBar: AppBar(
        title: Text('Online Quiz - Level ${widget.level}'),
      ),
      body: questionsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (questions) {
          final question = questions[currentQuestionIndex];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: _timerController.progress,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
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
                return OptionWidget(
                  optionText: question.options[index],
                  index: index,
                  selectedOptionIndex: selectedOptionIndex,
                  isCorrect: selectedOptionIndex == index
                      ? question.answerIndex == index
                      : null,
                  onSelectOption: (selectedIndex) {
                    setState(() {
                      selectedOptionIndex = selectedIndex;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      goToNextQuestion(question.answerIndex == selectedIndex);
                    });
                  },
                );
              }),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timerController.stopTimer();
    super.dispose();
  }
}
