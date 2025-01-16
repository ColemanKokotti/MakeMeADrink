import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:makemeadrink/screens/auth/start_screen.dart';
import 'package:makemeadrink/screens/auth/welcome_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Make Me A Drink',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          onBackground: Colors.black,
          primary: Color.fromARGB(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromARGB(244, 143, 177, 1),
          onSecondary: Colors.white,
          tertiary: Color.fromARGB(255, 204, 128, 1),
          error: Colors.red,
          outline: Color(0xFF424242)
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status AuthenticationState.authenticated) {
            return const HomeScreen();
          }else{
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}