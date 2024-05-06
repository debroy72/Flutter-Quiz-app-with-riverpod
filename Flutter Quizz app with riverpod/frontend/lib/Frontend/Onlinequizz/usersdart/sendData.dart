import 'dart:convert';

import 'package:frontend/Frontend/Onlinequizz/usersdart/quizsendmodel.dart';
import 'package:http/http.dart' as http;

Future<void> sendQuizResults(QuizResult result) async {
  const String url = 'http://10.0.2.2:5001/submit-quiz-results';
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(result.toJson()),
  );

  if (response.statusCode == 200) {
  } else {
    throw Exception('Failed to submit quiz results');
  }
}
