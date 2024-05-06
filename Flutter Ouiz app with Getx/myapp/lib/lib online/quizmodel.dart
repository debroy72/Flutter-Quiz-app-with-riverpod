class Question {
  final String questionText;
  final List<String> options;
  final int answerIndex;

  Question(
      {required this.questionText,
      required this.options,
      required this.answerIndex});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      answerIndex: json['answerIndex'],
    );
  }
}
