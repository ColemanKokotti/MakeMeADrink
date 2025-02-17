import 'package:flutter/material.dart';

final ThemeData defaultTheme = ThemeData(
  primaryColor: Colors.teal,
  scaffoldBackgroundColor: Colors.tealAccent,
  appBarTheme: AppBarTheme(
    color: Colors.teal,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(Colors.pinkAccent),
      backgroundColor: WidgetStateProperty.all(Colors.teal),
    ),
  ),
  cardColor: Colors.pink[100],
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
