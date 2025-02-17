import 'package:flutter/material.dart';

final ThemeData vintageRetroTheme = ThemeData(
  primaryColor: Colors.orange,
  scaffoldBackgroundColor: Colors.brown[50],
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    color: Colors.brown,
  ),
  iconTheme: IconThemeData(color: Colors.orangeAccent),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.brown,
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.orangeAccent, fontSize: 30),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.orangeAccent,
      backgroundColor: Colors.brown,
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.brown[50],
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
    ),
    textStyle: TextStyle(color: Colors.orangeAccent, fontSize: 18),
  ),
);
