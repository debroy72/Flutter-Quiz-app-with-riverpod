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
      questionText: json['QuestionText'] ??
          'Default question text', // Provide a default value
      options: (json['Options'] as List<dynamic>?)?.cast<String>() ?? [],
      answerIndex: json['AnswerIndex'] as int? ?? 0,
    );
  }
}
