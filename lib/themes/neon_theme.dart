import 'package:flutter/material.dart';

final ThemeData neonFuturisticTheme = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.pinkAccent,
  appBarTheme: AppBarTheme(
    color: Colors.black,
  ),
  iconTheme: IconThemeData(color: Colors.greenAccent),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.pinkAccent,
    textTheme: ButtonTextTheme.primary,
  ),
  brightness: Brightness.dark,
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.greenAccent, fontSize: 30),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.pinkAccent,
      backgroundColor: Colors.black,
    ),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.greenAccent)),
    ),
    textStyle: TextStyle(color: Colors.greenAccent, fontSize: 18),
  ),
);
