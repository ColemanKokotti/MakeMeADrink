import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Color.fromARGB(200, 50, 50, 50),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(200, 150, 150, 150),
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.black),
  iconTheme: IconThemeData(color: Colors.white),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.grey,
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.black54)
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.white, fontSize: 30),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromARGB(200, 50, 50, 50),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      textStyle: TextStyle(color: Colors.white, fontSize: 30)
  ),
  brightness: Brightness.dark,
);
