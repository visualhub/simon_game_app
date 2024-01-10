import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lights/simon_game_controller.dart';
import 'package:lights/simon_game_view.dart';

void main() {
  runApp(const SimonGameApp());
}

class SimonGameApp extends StatelessWidget {
  const SimonGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SimonGameController());
    return const GetMaterialApp(
      home: SimonGame(),
    );
  }
}
