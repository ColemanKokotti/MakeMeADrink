import 'package:flutter/material.dart';

final ThemeData materialDesignTheme = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.orange,
  ),
  buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
  iconTheme: IconThemeData(color: Colors.blue),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(
    foregroundColor: Colors.black,
    backgroundColor: Colors.blue,
  )),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(foregroundColor: Colors.blue, backgroundColor: Colors.orange)
  ),
  textTheme: TextTheme(
    labelLarge: TextStyle(color: Colors.blue, fontSize: 30),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.blue,
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
      ),
      textStyle: TextStyle(color: Colors.black, fontSize: 30)
  ),
);
