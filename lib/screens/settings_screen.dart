import 'dart:developer';
import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../button/change_theme_button.dart';
import 'package:makemeadrink/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text("Settings"),
          ),
          body: Center(
            child: ChangeThemeButton(
              onThemeChanged: (bool isDark) {
                themeProvider.toggleTheme();
                if (isDark) {
                  printToConsole('Dark Theme is set');
                } else {
                  printToConsole('Default Theme is set');
                }
              },
            ),
          ),
        );
      },
    );
  }
}


