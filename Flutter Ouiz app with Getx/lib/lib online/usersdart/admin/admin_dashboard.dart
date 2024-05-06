import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizResult {
  final String username;
  final int correctanswers;

  QuizResult({required this.username, required this.correctanswers});

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      username: json['username'],
      correctanswers: json['correctAnswers'],
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  Future<List<QuizResult>> _fetchQuizResults() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:5001/quiz-results'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => QuizResult.fromJson(data)).toList();
    } else {
      // Handle the case where the server returns a non-200 HTTP response
      throw Exception('Failed to load quiz results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: FutureBuilder<List<QuizResult>>(
        future: _fetchQuizResults(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final quizResults = snapshot.data!;
            return Column(
              children: [
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Score',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: quizResults.length,
                    itemBuilder: (context, index) {
                      final result = quizResults[index];
                      return ListTile(
                        title: Text(result.username),
                        trailing: Text('${result.correctanswers}'),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No quiz results found'));
          }
        },
      ),
    );
  }
}
