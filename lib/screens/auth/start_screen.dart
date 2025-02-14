import 'package:flutter/material.dart';
import 'package:makemeadrink/text/custom_text.dart';
import 'package:makemeadrink/button/start_app_button.dart';

class StartScreen extends StatelessWidget {
  final String selectedTheme;
  final ValueChanged<String?> onThemeSelect;

  const StartScreen({
    super.key,
    required this.selectedTheme,
    required this.onThemeSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
            StartApp(
              selectedTheme: selectedTheme,
              onThemeSelect: onThemeSelect,
            ),
          ],
        ),
      ),
    );
  }
}
