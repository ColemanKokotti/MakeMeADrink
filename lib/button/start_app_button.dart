import 'package:flutter/material.dart';
import 'package:makemeadrink/screens/auth/welcome_screen.dart';

class StartApp extends StatefulWidget {
  final String selectedTheme;
  final ValueChanged<String?> onThemeSelect;
  const StartApp({super.key,required this.selectedTheme,
    required this.onThemeSelect,});
  @override
  State<StartApp> createState() {
    return _StartAppButton();
  }
}

class _StartAppButton extends State<StartApp> {
  void startApp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WelcomeScreen(	selectedTheme: widget.selectedTheme,
        onThemeSelect: widget.onThemeSelect,)),
    );
  }

  @override
  Widget build(context) {
    return TextButton(
      onPressed: startApp,
      style: TextButton.styleFrom(
          padding: EdgeInsets.all(40),
          backgroundColor: Color.fromARGB(255, 230, 57, 70),
          foregroundColor: Colors.black,
          textStyle: TextStyle(fontSize: 30)),
      child: const Text(" Let's Drink !"),
    );
  }
}
