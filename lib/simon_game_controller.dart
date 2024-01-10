import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SimonGameController extends GetxController {
  final sequence = <String>[].obs;
  final userSequence = <String>[].obs;
  final score = 0.obs;
  final isPlaying = false.obs;
  final sequenceColor = ''.obs;
  final isColorPressEnabled = false.obs;

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
      'yellow',
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
    isColorPressEnabled.value = false;
    await Future.delayed(const Duration(milliseconds: 500));
    for (String color in sequence) {
      sequenceColor.value = color;
      await Future.delayed(const Duration(milliseconds: 500));
      sequenceColor.value = "";
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint('$sequence');
      update();
    }
    isColorPressEnabled.value = true;
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
