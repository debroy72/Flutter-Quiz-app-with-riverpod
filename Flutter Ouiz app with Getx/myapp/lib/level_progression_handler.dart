import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/quiz_state_manager.dart'; // Adjust import as needed
import 'package:myapp/sample_data.dart'; // Adjust import as needed

class LevelProgressionUtil {
  static void checkAndHandleLevelCompletion({
    required BuildContext context,
    required WidgetRef ref,
    required int currentQuestionIndex,
    required int currentLevelIndex,
    required int correctAnswersCount, // Add this to track correct answers
    required VoidCallback onLevelComplete,
    required VoidCallback onQuizComplete,
    required VoidCallback
        onLevelFail, // Callback for failing to meet the criteria
  }) {
    final bool isLastQuestion =
        currentQuestionIndex >= levels[currentLevelIndex].questions.length - 1;
    final bool isLastLevel = currentLevelIndex == levels.length - 1;
    final bool hasPassedLevel = correctAnswersCount >=
        8; // Check if the user has enough correct answers

    // Dynamically determine the award based on the level
    String awardMessage;
    switch (currentLevelIndex) {
      case 0:
        awardMessage = "Bronze Medal for Level ${currentLevelIndex + 1}";
        break;
      case 1:
        awardMessage = "Silver Medal for Level ${currentLevelIndex + 1}";
        break;
      case 2:
        awardMessage = "Gold Medal for Level ${currentLevelIndex + 1}";
        break;
      default:
        awardMessage = "Award for Level ${currentLevelIndex + 1}";
        break;
    }

    if (isLastQuestion) {
      if (hasPassedLevel) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Congratulations!"),
              content: Text(
                  "You've completed Level $currentLevelIndex. Your award is: $awardMessage"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (!isLastLevel) {
                      ref
                          .read(quizProvider.notifier)
                          .completeLevel(currentLevelIndex, awardMessage);
                      onLevelComplete();
                    } else {
                      onQuizComplete();
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle the case where the user hasn't passed the level
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Try Again"),
              content: Text(
                  "You need at least 8 correct answers to pass Level $currentLevelIndex. Please try again."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onLevelFail();
                  },
                  child: const Text('Retry'),
                ),
              ],
            );
          },
        );
      }
    } else {
      onLevelComplete();
    }
  }
}
