import 'package:flutter/material.dart';

enum ThemeType {
  drink,
  light,
  dark,
  pastel,
  vintage,
  neon
}

extension ThemeTypeExtension on ThemeType {
  String get name => toString().split('.').last;
}

class ThemeState {
  final ThemeType currentTheme;
  final ThemeData themeData;

  ThemeState({
    required this.currentTheme,
    required this.themeData,
  });

  ThemeState copyWith({
    ThemeType? currentTheme,
    ThemeData? themeData,
  }) {
    return ThemeState(
      currentTheme: currentTheme ?? this.currentTheme,
      themeData: themeData ?? this.themeData,
    );
  }
}