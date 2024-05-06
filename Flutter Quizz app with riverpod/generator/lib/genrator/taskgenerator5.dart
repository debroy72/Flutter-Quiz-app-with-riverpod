import 'dart:math';

class PatternQuestion {
  final String sequence;
  final String nextElement;
  final bool answer;

  PatternQuestion({
    required this.sequence,
    required this.nextElement,
    required this.answer,
  });
}

class PatternTaskGenerator {
  final int numberOfQuestions;
  final List<PatternQuestion> questions = [];
  final Random random = Random();

  PatternTaskGenerator({required this.numberOfQuestions});

  void generate() {
    List<Map<String, dynamic>> templates = [
      {
        "sequence": "2, 4, 6, 8",
        "next": "10",
        "correct": true,
      },
      {
        "sequence": "5, 10, 15, 20",
        "next": "25",
        "correct": true,
      },
      {
        "sequence": "1, 1, 2, 3, 5",
        "next": "7",
        "correct": false,
      },
      {
        "sequence": "A, C, E, G",
        "next": "I",
        "correct": true,
      },
    ];

    for (int i = 0; i < numberOfQuestions; i++) {
      var template = templates[random.nextInt(templates.length)];
      questions.add(
        PatternQuestion(
          sequence: template["sequence"],
          nextElement: "${template["next"]}",
          answer: template["correct"],
        ),
      );
    }
  }

  List<PatternQuestion> getGeneratedQuestions() {
    return questions;
  }
}
