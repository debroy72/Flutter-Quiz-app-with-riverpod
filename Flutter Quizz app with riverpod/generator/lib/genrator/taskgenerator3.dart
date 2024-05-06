import 'dart:math';

class DeductiveQuestion {
  final String question;
  final bool answer;

  DeductiveQuestion({required this.question, required this.answer});
}

class DeductiveTaskGenerator {
  final int numberOfQuestions;
  final List<DeductiveQuestion> questions = [];
  final Random random = Random();

  DeductiveTaskGenerator({required this.numberOfQuestions});

  void generate() {
    for (int i = 0; i < numberOfQuestions; i++) {
      int template = random.nextInt(3);
      DeductiveQuestion question;

      switch (template) {
        case 0:
          bool answer = true;
          question = DeductiveQuestion(
              question:
                  "If all A are B, and all B are C, can we conclude all A are C?",
              answer: answer);
          break;
        case 1:
          bool randAnswer = random.nextBool();
          String conclusion = randAnswer ? "no A are C?" : "some A are C?";
          question = DeductiveQuestion(
              question:
                  "If no A are B, and all B are C, can we conclude $conclusion",
              answer: randAnswer);
          break;
        case 2:
          bool validConclusion = false;
          question = DeductiveQuestion(
              question:
                  "If some A are B, and no B are C, can we conclude no A are C?",
              answer: validConclusion);
          break;
        default:
          question =
              DeductiveQuestion(question: "Default question", answer: false);
      }

      questions.add(question);
    }
  }

  List<DeductiveQuestion> getGeneratedQuestions() {
    return questions;
  }
}
