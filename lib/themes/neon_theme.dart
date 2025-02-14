import 'package:flutter/material.dart';

class ThemeNeonFuturistic {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(color: Colors.greenAccent),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.pinkAccent,
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.dark,
    );
  }
}
