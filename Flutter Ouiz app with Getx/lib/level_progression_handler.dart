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
    String assetName = '';
    // Dynamically determine the award based on the level
    String awardMessage;
    switch (currentLevelIndex) {
      case 0:
        awardMessage = "Bronze Award for Level ${currentLevelIndex + 1}";
        assetName = 'assests/images/bronze_medal.jpg';
        break;
      case 1:
        awardMessage = "Silver Award for Level ${currentLevelIndex + 1}";
        assetName = 'assests/images/silver_medal.jpg';

        break;
      case 2:
        awardMessage = "Gold Award for Level ${currentLevelIndex + 1}";
        assetName = 'assests/images/gold_medal.jpg';
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(assetName), // Display the award image
                  Text(
                      "You've completed Level $currentLevelIndex. Your award is: $awardMessage"),
                ],
              ),
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      "You need at least 8 correct answers to pass the level. Please try again."),
                  // Add an image below the text message
                  Image.asset(
                      'assests/images/sadkitty.jpg'), // Replace with your actual asset path
                ],
              ),
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
