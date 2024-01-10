import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return color == 'red'
        ? Colors.redAccent.withOpacity(0.6)
        : color == 'blue'
            ? Colors.blueAccent.withOpacity(0.6)
            : color == 'green'
                ? Colors.greenAccent.withOpacity(0.6)
                : color == 'yellow'
                    ? Colors.amberAccent.withOpacity(0.6)
                    : color == 'pink'
                        ? Colors.pinkAccent.withOpacity(0.6)
                        : color == 'orange'
                            ? Colors.orangeAccent.withOpacity(0.6)
                            : color == 'teal'
                                ? Colors.tealAccent.withOpacity(0.6)
                                : color == 'indigo'
                                    ? Colors.indigoAccent.withOpacity(0.6)
                                    : Colors.purpleAccent.withOpacity(0.6);
  }

  Color _getDefaultColor(String color) {
    return color == 'red'
        ? Colors.red
        : color == 'blue'
            ? Colors.blue
            : color == 'green'
                ? Colors.green
                : color == 'yellow'
                    ? Colors.amber
                    : color == 'pink'
                        ? Colors.pink
                        : color == 'orange'
                            ? Colors.orange
                            : color == 'teal'
                                ? Colors.teal
                                : color == 'indigo'
                                    ? Colors.indigo
                                    : Colors.purple;
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text(
                'Score: ${controller.score}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed:
                    controller.isPlaying.value ? null : controller.startGame,
                child: const Text('Start Game'),
              ),
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
                buildColorButton('yellow'),
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
          ],
        ),
      ),
    );
  }
}
