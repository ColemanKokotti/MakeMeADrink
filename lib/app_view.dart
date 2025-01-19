import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:makemeadrink/screens/auth/start_screen.dart';
import 'package:makemeadrink/screens/auth/welcome_screen.dart';
import 'package:makemeadrink/screens/looding_screen.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
			title: 'Firebase Auth',
			theme: ThemeData(
				colorScheme: const ColorScheme.light(
          surface: Colors.white,
          onSurface: Colors.black,
          primary: Color.fromRGBO(206, 147, 216, 1),
          onPrimary: Colors.black,
          secondary: Color.fromRGBO(244, 143, 177, 1),
          onSecondary: Colors.white,
					tertiary: Color.fromRGBO(255, 204, 128, 1),
          error: Colors.red,
					outline: Color(0xFF424242)
        ),
			),
				home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
						builder: (context, state) {
							if (state.status == AuthenticationStatus.authenticated) {
								return const StartScreen();
							} else if (state.status == AuthenticationStatus.unauthenticated) {
								return BlocProvider(
									create: (context) => SignInBloc(
											userRepository: context.read<AuthenticationBloc>().userRepository
									),
									child: const StartScreen(),
								);
							} else {
								// AuthenticationStatus.unknown
								return const SplashScreen();
							}
						}
				)
		);
  }
}