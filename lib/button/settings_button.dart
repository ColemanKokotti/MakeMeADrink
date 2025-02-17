import 'package:flutter/material.dart';
import 'package:makemeadrink/screens/settings_screen.dart';
import 'package:makemeadrink/theme_bloc_providers//theme_provider.dart';

class SettingsButton extends StatefulWidget {
  const SettingsButton({super.key});

  @override
  State<SettingsButton> createState() {
    return _StartSettings();
  }
}

class _StartSettings extends State<SettingsButton> {
  String selectedTheme = 'default';

  void _updateTheme(String? newTheme) {
    setState(() {
      selectedTheme = newTheme ?? 'default';
      ThemeProvider.selectTheme(selectedTheme);
    });
  }

  void startSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          selectedTheme: selectedTheme,
          onThemeSelect: _updateTheme,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: startSettings,
      icon: Icon(Icons.settings),
    );
  }
}

