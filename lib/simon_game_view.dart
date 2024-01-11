import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lights/custom_bottom_sheet.dart';
import 'package:lights/simon_game_controller.dart';

class SimonGame extends GetView<SimonGameController> {
  const SimonGame({Key? key}) : super(key: key);

  Widget buildColorButton(String color) {
    return Obx(
      () => CupertinoButton(
        onPressed: controller.isColorPressEnabled.value
            ? () => controller.onColorPressed(color)
            : null,
        child: Container(
          height: Get.height * 0.1,
          width: Get.width * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: controller.sequenceColor.value == color
                ? _getHighlightedColor(color)
                : _getDefaultColor(color),
            boxShadow: _getButtonBoxShadow(color),
          ),
        ),
      ),
    );
  }

  Color _getHighlightedColor(String color) {
    return switch (color) {
      'red' => Colors.redAccent.withOpacity(0.6),
      'blue' => Colors.blueAccent.withOpacity(0.6),
      'pink' => Colors.pinkAccent.withOpacity(0.6),
      'teal' => Colors.tealAccent.withOpacity(0.6),
      'green' => Colors.greenAccent.withOpacity(0.6),
      'amber' => Colors.amberAccent.withOpacity(0.6),
      'indigo' => Colors.indigoAccent.withOpacity(0.6),
      'purple' => Colors.purpleAccent.withOpacity(0.6),
      'orange' => Colors.orangeAccent.withOpacity(0.6),
      _ => Colors.white.withOpacity(0.6),
    };
  }

  Color _getDefaultColor(String color) {
    return switch (color) {
      'red' => Colors.red,
      'blue' => Colors.blue,
      'pink' => Colors.pink,
      'teal' => Colors.teal,
      'green' => Colors.green,
      'amber' => Colors.amber,
      'indigo' => Colors.indigo,
      'purple' => Colors.purple,
      'orange' => Colors.orange,
      _ => Colors.white,
    };
  }

  List<BoxShadow> _getButtonBoxShadow(String color) {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 5,
        spreadRadius: 2,
      ),
      if (controller.userSequence.isNotEmpty &&
          controller.userSequence.last == color)
        BoxShadow(
          color: _getHighlightedColor(color),
          blurRadius: 10,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simon Game'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: !controller.isPlaying.value
                  ? () {
                      _bottomSheet(context);
                    }
                  : null,
              icon: const Icon(Icons.settings),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.black12,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mode: ${controller.difficultyMode.value.name}',
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 20),
              Text(
                'Best you have Done : ${controller.score}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                'Score: ${controller.score}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildColorButton('red'),
                  buildColorButton('blue'),
                  buildColorButton('green'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildColorButton('amber'),
                  buildColorButton('pink'),
                  buildColorButton('orange'),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildColorButton('teal'),
                  buildColorButton('indigo'),
                  buildColorButton('purple'),
                ],
              ),
              const SizedBox(height: 20),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isPlaying.value ? null : controller.startGame,
                  child: const Text('Start Game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const CustomBottomSheet();
      },
    );
  }
}
