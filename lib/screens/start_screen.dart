import 'package:flutter/material.dart';
import 'package:makemeadrink/text/custom_text.dart';
import 'package:makemeadrink/backgroundcolor/background_color.dart';
import 'package:makemeadrink/button/start_app_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(context) {
    return Scaffold(
      body: BackgraoundColor(
        [
          Color.fromARGB(255, 255, 0, 127),
          Color.fromARGB(255, 50, 205, 50),
          Color.fromARGB(255, 30, 144, 255)
        ],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText("Make Me A Drink"),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/startScreenImage.png",
                width: 300,
              ),
              const SizedBox(
                height: 60,
              ),
              StartApp(),
            ],
          ),
        ),
      ),
    );
  }
}
