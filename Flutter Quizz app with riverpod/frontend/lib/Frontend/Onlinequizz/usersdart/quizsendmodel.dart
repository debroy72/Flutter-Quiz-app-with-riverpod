class QuizResult {
  final String username;
  final int correctAnswers;

  QuizResult({required this.username, required this.correctAnswers});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'correctAnswers': correctAnswers,
    };
  }
}
