import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makemeadrink/screens/start_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StartScreen(),
        ),
      ));
}
