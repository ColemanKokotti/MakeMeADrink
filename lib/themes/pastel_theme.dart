import 'package:flutter/material.dart';

class ThemePastelRelaxing {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: Colors.pink[100],
      scaffoldBackgroundColor: Colors.pink[50],
      appBarTheme: AppBarTheme(
        color: Colors.pink[100],
      ),
      iconTheme: IconThemeData(color: Colors.pink[300]),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.pink[200],
        textTheme: ButtonTextTheme.primary,
      ),
      brightness: Brightness.light,
    );
  }
}
