import 'dart:math';

class InductiveQuestion {
  final String question;
  final bool answer;

  InductiveQuestion({required this.question, required this.answer});
}

class InductiveTaskGenerator {
  final int numberOfQuestions;
  final List<InductiveQuestion> questions = [];
  final Random random = Random();

  InductiveTaskGenerator({required this.numberOfQuestions});

  void generate() {
    for (int i = 0; i < numberOfQuestions; i++) {
      int patternType = random.nextInt(3);
      InductiveQuestion question;

      switch (patternType) {
        case 0:
          bool answer = random.nextBool();
          question = InductiveQuestion(
            question:
                "If the sequence is 2, 4, 6, 8, what comes next? Is it 10?",
            answer: answer,
          );
          break;
        case 1:
          bool observationOutcome = random.nextBool();
          question = InductiveQuestion(
            question:
                "Observing that the sun has risen every day, can we conclude it will rise tomorrow?",
            answer: observationOutcome,
          );
          break;
        case 2:
          bool analogyOutcome = random.nextBool();
          question = InductiveQuestion(
            question:
                "Seeing that a bird can fly because it has wings, can we conclude that all winged creatures can fly?",
            answer: analogyOutcome,
          );
          break;
        default:
          question = InductiveQuestion(question: "Is water wet?", answer: true);
      }

      questions.add(question);
    }
  }

  List<InductiveQuestion> getGeneratedQuestions() {
    return questions;
  }
}
