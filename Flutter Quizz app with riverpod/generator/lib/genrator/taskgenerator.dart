import 'dart:math';

class LogicQuestion {
  String question;
  bool answer;

  LogicQuestion({required this.question, required this.answer});
}

class LogicTaskGenerator {
  final int numberOfQuestions;
  final List<LogicQuestion> questions = [];
  final Random random = Random();

  LogicTaskGenerator({required this.numberOfQuestions});

  LogicQuestion generateLogicExpression() {
    int structure = random.nextInt(6);
    String question;
    bool answer;

    bool p = random.nextBool();
    bool q = random.nextBool();
    bool r = random.nextBool();
    bool s = random.nextBool();

    switch (structure) {
      case 0:
        question =
            'If p is ${p ? 'true' : 'false'}, q is ${q ? 'true' : 'false'}, and r is ${r ? 'true' : 'false'}, what is the truth value of the expression: p AND (q OR NOT r)?';
        answer = p && (q || !r);
        break;
      case 1:
        question =
            'If p is ${p ? 'true' : 'false'}, q is ${q ? 'true' : 'false'}, and r is ${r ? 'true' : 'false'}, what is the truth value of the expression: (p OR q) AND NOT r?';
        answer = (p || q) && !r;
        break;
      case 2:
        question =
            'If p is ${p ? 'true' : 'false'}, q is ${q ? 'true' : 'false'}, and r is ${r ? 'true' : 'false'}, what is the truth value of the expression: NOT (p AND q) OR r?';
        answer = !(p && q) || r;
        break;
      case 3:
        question =
            'If p is ${p ? 'true' : 'false'}, q is ${q ? 'true' : 'false'}, and r is ${r ? 'true' : 'false'}, what is the truth value of the expression: (NOT p OR q) AND r?';
        answer = (!p || q) && r;
        break;
      case 4:
        question =
            'If p is ${p ? 'true' : 'false'}, q is ${q ? 'true' : 'false'}, r is ${r ? 'true' : 'false'}, and s is ${s ? 'true' : 'false'}, what is the truth value of the expression: ((p AND q) OR (r AND NOT s))?';
        answer = (p && q) || (r && !s);
        break;
      case 5:
        question =
            'If p is ${p ? 'true' : 'false'}, q is ${q ? 'true' : 'false'}, r is ${r ? 'true' : 'false'}, and s is ${s ? 'true' : 'false'}, what is the truth value of the expression: (NOT p AND q) OR (r OR NOT s)?';
        answer = (!p && q) || (r || !s);
        break;
      default:
        question = 'Default Question';
        answer = false;
    }

    return LogicQuestion(question: question, answer: answer);
  }

  void generate() {
    while (questions.length < numberOfQuestions) {
      LogicQuestion newQuestion = generateLogicExpression();

      if (!questions.any((q) => q.question == newQuestion.question)) {
        questions.add(newQuestion);
      }
    }
  }

  List<LogicQuestion> getGeneratedQuestions() {
    return questions;
  }
}
