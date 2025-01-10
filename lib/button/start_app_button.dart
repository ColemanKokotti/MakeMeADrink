import 'package:flutter/material.dart';

class StartApp extends StatefulWidget {
  const StartApp({super.key});
  @override
  State<StartApp> createState() {
    return _StartAppButton();
  }
}

class _StartAppButton extends State<StartApp> {
  void startApp() {}
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
