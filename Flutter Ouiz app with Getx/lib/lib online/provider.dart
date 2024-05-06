import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/lib%20online/quizappservice.dart';
import 'package:myapp/lib%20online/quizmodel.dart';

final quizApiProvider = Provider<QuizApiService>((ref) {
  return QuizApiService(); // Adjust baseUrl if necessary
});

final questionsProvider = FutureProvider<List<Question>>((ref) async {
  // Assuming QuizApiService's fetchQuestions method returns Future<List<Question>>
  final quizApi = ref.read(quizApiProvider);
  return await quizApi.fetchQuestions();
});
