import 'dart:convert';

import 'package:http/http.dart' as http; // Import the http package
import 'package:myapp/lib%20online/quizmodel.dart';

class QuizApiService {
  final String baseUrl = 'http://10.0.2.2:5000'; // Adjust based on your setup

  QuizApiService(String s);

  Future<List<Question>> fetchQuestions(int level) async {
    final response = await http.get(Uri.parse('$baseUrl/questions/$level'));
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      return List<Question>.from(l.map((model) => Question.fromJson(model)));
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
