import 'package:flutter/material.dart';

class ThemeMaterialDesign {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.blue
      ),
      iconTheme: IconThemeData(color: Colors.blueAccent),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.orange,
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.light,
      textTheme: TextTheme(
        labelLarge: TextStyle(color: Colors.orange),
      ),
    );
  }
}
