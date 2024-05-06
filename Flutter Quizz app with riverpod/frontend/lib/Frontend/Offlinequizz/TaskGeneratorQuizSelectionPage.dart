import 'package:flutter/material.dart';
import 'package:frontend/Frontend/Taskgenerator/autotask.dart';
import 'package:frontend/Frontend/Taskgenerator/autotask2.dart';
import 'package:frontend/Frontend/Taskgenerator/autotask3.dart';
import 'package:frontend/Frontend/Taskgenerator/autotask4.dart';
import 'package:frontend/Frontend/Taskgenerator/autotask5.dart';

class autoQuizSelectionPage extends StatelessWidget {
  const autoQuizSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Quiz'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/images/quizzselectionbg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildQuizButton(
                  context, "TaskGenerator Quiz 1", const AutoTaskPage()),
              _buildQuizButton(
                  context, "TaskGenerator Quiz 2", const AutoTaskPage2()),
              _buildQuizButton(context, "TaskGenerator Quiz 3",
                  const AutoTaskPageDeductive()),
              _buildQuizButton(context, "TaskGenerator Quiz 4",
                  const AutoTaskPageInductive()),
              _buildQuizButton(
                  context, "TaskGenerator Quiz 5", const AutoTaskPagePattern()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizButton(
      BuildContext context, String text, Widget AutoTaskPage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AutoTaskPage),
          );
        },
        child: Text(text),
      ),
    );
  }
}

Widget _buildQuizButton(
    BuildContext context, String text, Widget AutoTaskPage2) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AutoTaskPage2),
        );
      },
      child: Text(text),
    ),
  );
}
