// quiz_state_manager.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sample_data.dart';

final quizProvider = StateNotifierProvider<QuizManager, QuizState>((ref) {
  return QuizManager();
});

class QuizState {
  final int currentLevelIndex;
  final List<bool> levelsCompleted;
  final List<String> awards;

  QuizState({
    this.currentLevelIndex = 0,
    List<bool>? levelsCompleted,
    List<String>? awards,
  })  : levelsCompleted =
            levelsCompleted ?? List.generate(levels.length, (_) => false),
        awards = awards ?? [];

  QuizState copyWith({
    int? currentLevelIndex,
    List<bool>? levelsCompleted,
    List<String>? awards,
  }) {
    return QuizState(
      currentLevelIndex: currentLevelIndex ?? this.currentLevelIndex,
      levelsCompleted: levelsCompleted ?? List.from(this.levelsCompleted),
      awards: awards ?? List.from(this.awards),
    );
  }
}

class QuizManager extends StateNotifier<QuizState> {
  QuizManager() : super(QuizState());

  void completeLevel(int completedLevelIndex, String award) {
    var newState = state.copyWith();
    newState.levelsCompleted[completedLevelIndex] = true;
    newState.awards.add(award);
    if (completedLevelIndex < levels.length - 1) {
      newState =
          newState.copyWith(currentLevelIndex: newState.currentLevelIndex + 1);
    }
    state = newState;
  }

  void reset() {
    state = QuizState(
      currentLevelIndex: 0,
      levelsCompleted: List.generate(levels.length, (_) => false),
      awards: [],
    );
  }
}
