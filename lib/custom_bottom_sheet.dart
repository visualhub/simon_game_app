import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lights/simon_game_controller.dart';

class CustomBottomSheet extends GetView<SimonGameController> {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      height: Get.height * 0.4,
      width: Get.width,
      child: Column(
        children: [
          const Text(
            'Difficulty Levels',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          _customButton(
            buttonText: 'Easy',
            onPressed: () {
              Navigator.pop(context);
              controller.setDifficultyMode(DifficultyMode.easy);
            },
          ),
          const Divider(),
          _customButton(
            buttonText: 'Medium',
            onPressed: () {
              Navigator.pop(context);
              controller.setDifficultyMode(DifficultyMode.medium);
            },
          ),
          const Divider(),
          _customButton(
            buttonText: 'Hard',
            onPressed: () {
              Navigator.pop(context);
              controller.setDifficultyMode(DifficultyMode.hard);
            },
          ),
        ],
      ),
    );
  }

  CupertinoButton _customButton({
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return CupertinoButton(
      color: Colors.black.withOpacity(0.1),
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: Get.width,
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
