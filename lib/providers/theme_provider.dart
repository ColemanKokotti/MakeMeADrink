import 'package:flutter/material.dart';
import '/themes/neon_theme.dart';
import '/themes/vintageRetro_theme.dart';
import '/themes/pastel_theme.dart';
import '/themes/default_theme.dart';
import '/themes/theme_dark.dart';
import '/themes/materialDesign_theme.dart';

class ThemeProvider {
  static ThemeData _currentTheme = defaultTheme;

  static ThemeData get currentTheme => _currentTheme;

  static void selectTheme(String themeName) {
    switch (themeName) {
      case 'light':
        _currentTheme = materialDesignTheme;
        break;
      case 'dark':
        _currentTheme = darkTheme;
        break;
      case 'pastel':
        _currentTheme = pastelTheme;
        break;
      case'neon':
        _currentTheme = neonFuturisticTheme;
        break;
      case'vintage':
        _currentTheme = vintageRetroTheme;
        break;
      case 'default':
      default:
        _currentTheme = defaultTheme;
        break;
    }
  }
}
