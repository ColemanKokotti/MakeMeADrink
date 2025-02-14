import 'package:flutter/material.dart';

class ThemeDark {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Color.fromARGB(200, 50, 50, 50),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(200, 150, 150, 150),
      ),
      buttonTheme: ButtonThemeData(buttonColor: Colors.black),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.grey),
        ),
      ),
      textTheme: TextTheme(
        labelLarge: TextStyle(color: Colors.white),
      ),
    );
  }
}

