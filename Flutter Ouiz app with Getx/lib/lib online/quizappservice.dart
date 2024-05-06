// quiz_api_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/lib%20online/quizmodel.dart';

class QuizApiService {
  final String baseUrl = 'http://10.0.2.2:5000'; // Adjust the URL as needed

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
