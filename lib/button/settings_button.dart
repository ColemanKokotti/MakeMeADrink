import 'package:flutter/material.dart';
import 'package:makemeadrink/screens/settings_screen.dart';


class SettingsButton extends StatefulWidget {
  const SettingsButton({super.key});
  @override
  State<SettingsButton> createState() {
    return _StartSettings();
  }
}

class _StartSettings extends State<SettingsButton> {
  void startSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }


@override
Widget build(context) {
  return IconButton(
    onPressed: startSettings,
    icon: Icon(Icons.settings),
  );
}
}