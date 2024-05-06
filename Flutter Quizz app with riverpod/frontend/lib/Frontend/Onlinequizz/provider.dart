import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Onlinequizz/quizappservice.dart';
import 'package:frontend/Frontend/Onlinequizz/quizmodel.dart';

final quizApiProvider = Provider<QuizApiService>((ref) {
  return QuizApiService(); // Adjust baseUrl if necessary
});

final questionsProvider = FutureProvider<List<Question>>((ref) async {
  final quizApi = ref.read(quizApiProvider);
  return await quizApi.fetchQuestions();
});
