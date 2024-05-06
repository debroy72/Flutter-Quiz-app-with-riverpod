import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/lib%20online/usersdart/quizsendmodel.dart';

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
    // Handle successful response
  } else {
    // Handle error
    throw Exception('Failed to submit quiz results');
  }
}
