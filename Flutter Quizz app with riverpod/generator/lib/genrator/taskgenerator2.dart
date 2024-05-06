import 'dart:math';

class SyllogismQuestion {
  String premises;
  String conclusion;
  bool answer;

  SyllogismQuestion(
      {required this.premises, required this.conclusion, required this.answer});
}

class SyllogismTaskGenerator {
  final int numberOfQuestions;
  final List<SyllogismQuestion> questions = [];
  final Random random = Random();

  SyllogismTaskGenerator({required this.numberOfQuestions});

  SyllogismQuestion generateSyllogismQuestion() {
    List<String> subjects = ['All A are B', 'No B are C', 'Some A are not C'];
    List<String> conclusions = [
      'Therefore, some A are B',
      'Therefore, no A are C',
      'Therefore, some B are not C'
    ];

    int premiseIndex = random.nextInt(subjects.length);
    int conclusionIndex = random.nextInt(conclusions.length);

    bool answer = random.nextBool();

    return SyllogismQuestion(
        premises:
            "${subjects[premiseIndex]}, ${subjects[(premiseIndex + 1) % subjects.length]}.",
        conclusion: conclusions[conclusionIndex],
        answer: answer);
  }

  void generate() {
    for (int i = 0; i < numberOfQuestions; i++) {
      SyllogismQuestion newQuestion = generateSyllogismQuestion();

      questions.add(newQuestion);
    }
  }

  List<SyllogismQuestion> getGeneratedQuestions() {
    return questions;
  }
}
