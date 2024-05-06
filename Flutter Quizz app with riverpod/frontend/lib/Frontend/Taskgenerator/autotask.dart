import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generator/genrator/taskgenerator.dart';

class AutoTaskPage extends StatefulWidget {
  const AutoTaskPage({Key? key}) : super(key: key);

  @override
  _AutoTaskPageState createState() => _AutoTaskPageState();
}

class _AutoTaskPageState extends State<AutoTaskPage> {
  late Future<List<LogicQuestion>> questionFuture;
  int currentQuestionIndex = 0;
  bool? selectedAnswer;

  @override
  void initState() {
    super.initState();

    questionFuture = generateQuestionsAsync();
  }

  Future<List<LogicQuestion>> generateQuestionsAsync() async {
    return await compute(generateLogicQuestions, 20);
  }

  static List<LogicQuestion> generateLogicQuestions(int numberOfQuestions) {
    LogicTaskGenerator generator =
        LogicTaskGenerator(numberOfQuestions: numberOfQuestions);
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
      setState(() {
        currentQuestionIndex = 0;
        selectedAnswer = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Quiz completed! Restarting...'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  void checkAnswerAndContinue(List<LogicQuestion> questions) {
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
        title: const Text('Formal Logic Quiz'),
      ),
      body: FutureBuilder<List<LogicQuestion>>(
        future: questionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<LogicQuestion> questions = snapshot.data!;
            LogicQuestion currentQuestion = questions[currentQuestionIndex];
            return buildQuestionPage(currentQuestion, questions);
          } else {
            return const Center(child: Text('No questions available.'));
          }
        },
      ),
    );
  }

  Widget buildQuestionPage(
      LogicQuestion currentQuestion, List<LogicQuestion> questions) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentQuestion.question,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
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
    title: 'Formal Logic Quiz',
    home: AutoTaskPage(),
  ));
}
