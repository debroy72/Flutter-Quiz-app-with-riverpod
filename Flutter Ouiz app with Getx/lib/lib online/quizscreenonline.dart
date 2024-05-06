import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/lib%20online/TimerController.dart';
import 'package:myapp/lib%20online/optionwidget.dart';
import 'package:myapp/lib%20online/quizappservice.dart';
import 'package:myapp/lib%20online/quizmodel.dart';
import 'package:myapp/lib%20online/usersdart/quizsendmodel.dart';
import 'package:myapp/lib%20online/usersdart/sendData.dart';

final quizApiProvider = Provider<QuizApiService>((ref) => QuizApiService());
final questionsProvider = FutureProvider<List<Question>>((ref) async {
  final quizApi = ref.read(quizApiProvider);
  return await quizApi.fetchQuestions();
});

class QuizScreen extends ConsumerStatefulWidget {
  final String username;
  const QuizScreen({Key? key, required this.username}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  late TimerController _timerController;
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  int correctAnswersCount = 0;
  bool? isAnswerCorrect;

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(
        duration: 20,
        onTick: (isDone) {
          if (isDone) goToNextQuestion();
        });
    _timerController.startTimer();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < 9) {
      // Assuming there are 10 questions
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isAnswerCorrect = null;
      });
      _timerController.reset();
    } else {
      _timerController.stopTimer();
      showCompletionDialog();
    }
  }

  void showCompletionDialog() async {
    // Stop the timer
    _timerController.stopTimer();

    // Submit quiz results before showing the completion dialog
    await submitQuizResults(); // Call the submission function here

    // Show the completion dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed!'),
        content: Text('You got $correctAnswersCount out of 10 correct!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Optionally reset quiz or navigate to results screen
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

// The submitQuizResults function as you provided it
  Future<void> submitQuizResults() async {
    final QuizResult result = QuizResult(
      username: widget.username, // Use the passed username
      correctAnswers: correctAnswersCount,
    );

    try {
      await sendQuizResults(result);
      // Handle successful submission, e.g., showing a toast or dialog
    } catch (e) {
      // Handle errors, e.g., showing a toast or dialog
      print('Failed to submit quiz results: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionsAsyncValue = ref.watch(questionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: questionsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
        data: (questions) {
          if (questions.isEmpty) {
            return const Center(child: Text('No questions available'));
          }
          final question = questions[currentQuestionIndex];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question.questionText,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              ...List.generate(question.options.length, (index) {
                bool isSelected = index == selectedOptionIndex;
                bool isOptionCorrect = index == question.answerIndex;
                return OptionWidget(
                  optionText: question.options[index],
                  index: index,
                  isSelected: isSelected,
                  isCorrect: isAnswerCorrect,
                  isOptionCorrect: isOptionCorrect,
                  onSelectOption: () {
                    if (!isSelected) {
                      setState(() {
                        selectedOptionIndex = index;
                        isAnswerCorrect = isOptionCorrect;
                        if (isOptionCorrect) {
                          correctAnswersCount++;
                        }
                      });
                      _timerController.stopTimer();
                      // Delay to show selected option color change
                      Future.delayed(
                          const Duration(seconds: 1), goToNextQuestion);
                    }
                  },
                );
              }),
              LinearProgressIndicator(
                value: _timerController.progress,
                backgroundColor: Colors.grey[200],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
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
