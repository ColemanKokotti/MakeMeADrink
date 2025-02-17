import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:makemeadrink/screens/auth/start_screen.dart';
import 'package:makemeadrink/screens/splash_screen.dart';
import 'package:makemeadrink/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_bloc.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_state.dart';

class MyAppView extends StatelessWidget {
	const MyAppView({super.key});

	@override
	Widget build(BuildContext context) {
		return BlocBuilder<ThemeBloc, ThemeState>(
			builder: (context, themeState) {
				return MaterialApp(
					debugShowCheckedModeBanner: false,
					title: 'Make Me A Drink',
					theme: themeState.themeData,
					home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
						builder: (context, state) {
							if (state.status == AuthenticationStatus.authenticated) {
								return BlocProvider(
									create: (context) => SignInBloc(
										userRepository: context.read<AuthenticationBloc>().userRepository,
									),
									child: const SplashScreen(),
								);
							} else if (state.status == AuthenticationStatus.unauthenticated) {
								return const StartScreen();
							} else {
								return const Center(child: CircularProgressIndicator());
							}
						},
					),
				);
			},
		);
	}
}
