import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimonGameController extends GetxController {
  final _sequence = <String>[].obs;
  final _userSequence = <String>[].obs;
  final _score = 0.obs;
  final _isPlaying = false.obs;
  final _sequenceColor = ''.obs;
  final _isColorPressEnabled = false.obs;
  final difficultyMode = DifficultyMode.medium.obs;

  get sequence => _sequence;
  get userSequence => _userSequence;
  get score => _score;
  get isPlaying => _isPlaying;
  get sequenceColor => _sequenceColor;
  get isColorPressEnabled => _isColorPressEnabled;

  void startGame() {
    sequence.clear();
    userSequence.clear();
    score.value = 0;
    isPlaying.value = true;
    addColorToSequence();
    playSequence();
    debugPrint('Start game');
  }

  void addColorToSequence() {
    final colors = [
      'red',
      'blue',
      'green',
      'amber',
      'pink',
      'orange',
      'purple',
      'teal',
      'indigo',
    ];
    final randomColor = colors[DateTime.now().millisecond % 9];
    sequence.add(randomColor);
  }

  Future<void> playSequence() async {
    print(difficultyMode);
    isColorPressEnabled.value = false;
    await Future.delayed(
      Duration(
        milliseconds: difficultyModeCheck(difficultyMode.value),
      ),
    );
    for (String color in sequence) {
      sequenceColor.value = color;
      await Future.delayed(
        Duration(
          milliseconds: difficultyModeCheck(difficultyMode.value),
        ),
      );
      sequenceColor.value = "";
      await Future.delayed(
        Duration(
          milliseconds: difficultyModeCheck(difficultyMode.value),
        ),
      );
      debugPrint('$sequence');
      update();
    }
    isColorPressEnabled.value = true;
  }

  int difficultyModeCheck(DifficultyMode mode) {
    return switch (mode) {
      DifficultyMode.easy => 750,
      DifficultyMode.hard => 150,
      _ => 500,
    };
  }

  void setDifficultyMode(DifficultyMode mode) {
    difficultyMode.value = mode;
    print(difficultyMode);
  }

  void onColorPressed(String color) {
    if (!isPlaying.value) return;

    userSequence.add(color);

    if (!checkUserInput()) {
      endGame();
    } else if (userSequence.length == sequence.length) {
      score.value++;
      userSequence.clear();
      addColorToSequence();
      playSequence();
    }
  }

  bool checkUserInput() {
    for (int i = 0; i < userSequence.length; i++) {
      if (userSequence[i] != sequence[i]) {
        return false;
      }
    }
    return true;
  }

  void endGame() {
    isPlaying.value = false;
    Get.snackbar(
      'Game Over',
      'Your score: ${score.value}',
    );
  }
}

enum DifficultyMode {
  easy,
  medium,
  hard,
}
