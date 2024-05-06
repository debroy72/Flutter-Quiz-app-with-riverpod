import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/lib%20online/quizappservice.dart';
import 'package:myapp/lib%20online/quizmodel.dart';

final quizApiProvider =
    Provider((ref) => QuizApiService('http://10.0.2.2:5000'));

final questionsProvider =
    FutureProvider.family<List<Question>, int>((ref, level) async {
  final quizApi = ref.watch(quizApiProvider);
  return quizApi.fetchQuestions(level);
});
