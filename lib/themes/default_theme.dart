import 'package:flutter/material.dart';

class ThemeDefault {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.black,
      colorScheme: const ColorScheme.light(
        surface: Colors.teal,
        onSurface: Colors.black,
        primary: Colors.tealAccent,
        onPrimary: Colors.black,
        secondary: Colors.tealAccent,
        onSecondary: Colors.white,
        tertiary: Colors.tealAccent,
        error: Colors.red,
        outline: Colors.teal,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.tealAccent,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.pinkAccent),
          backgroundColor: MaterialStateProperty.all(Colors.teal),
        ),
      ),
      iconTheme: IconThemeData(color: Colors.teal),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.tealAccent,
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.light,
      textTheme: TextTheme(
        labelLarge: TextStyle(color: Colors.black54),
      ),
    );
  }
}
