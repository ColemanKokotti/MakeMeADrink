import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: Colors.tealAccent,
  appBarTheme: AppBarTheme(
    color: Colors.teal,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.pinkAccent),
      backgroundColor: MaterialStateProperty.all(Colors.teal),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.teal[200]),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.tealAccent,
    textTheme: ButtonTextTheme.primary,
  ),
  brightness: Brightness.light,
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.black54, fontSize: 30),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.teal, backgroundColor: Colors.black54)
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.tealAccent,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
      textStyle: TextStyle(color: Colors.teal, fontSize: 30)
  ),
);
