// quiz_api_service.dart
import 'dart:convert';

import 'package:frontend/Frontend/Onlinequizz/quizmodel.dart';
import 'package:http/http.dart' as http;

class QuizApiService {
  final String baseUrl = 'http://10.0.2.2:5000';

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse('$baseUrl/questions'));
    if (response.statusCode == 200) {
      final List<dynamic> questionJson = json.decode(response.body);
      return questionJson.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
