import 'package:flutter/material.dart';

class ThemeVintageRetro {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.orange,
      scaffoldBackgroundColor: Colors.brown[50],
      appBarTheme: AppBarTheme(
        color: Colors.brown,
      ),
      iconTheme: IconThemeData(color: Colors.orangeAccent),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.brown,
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.light,
    );
  }
}
