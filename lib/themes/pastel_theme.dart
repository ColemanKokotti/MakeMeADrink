import 'package:flutter/material.dart';

final ThemeData pastelTheme = ThemeData(
  primaryColor: Colors.pink[100],
  scaffoldBackgroundColor: Colors.pink[50],
  appBarTheme: AppBarTheme(
    color: Colors.pink[100],
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.pinkAccent),
      backgroundColor: MaterialStateProperty.all(Colors.pink[200]),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.pink[300]),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.pink[200],
    textTheme: ButtonTextTheme.primary,
  ),
  brightness: Brightness.light,
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.pink[300], fontSize: 30),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.pink[300],
        backgroundColor: Colors.pink[200],
      )
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.pink[50],
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
    ),
    textStyle: TextStyle(color: Colors.pink[300], fontSize: 18),
  ),
);
