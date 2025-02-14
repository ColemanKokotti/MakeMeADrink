import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:makemeadrink/providers/theme_provider.dart';
import 'package:makemeadrink/screens/auth/start_screen.dart';
import 'package:makemeadrink/screens/splash_screen.dart';
import 'blocs/sign_in_bloc/sign_in_bloc.dart';

class MyAppView extends StatefulWidget {
	const MyAppView({super.key});

	@override
	_MyAppViewState createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
	String selectedTheme = 'default';

	void updateTheme(String? newTheme) {
		setState(() {
			selectedTheme = newTheme ?? 'default';
			ThemeProvider.selectTheme(selectedTheme);
		});
	}

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Make Me A Drink',
			theme: ThemeProvider.currentTheme,
			home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
				builder: (context, state) {
					if (state.status == AuthenticationStatus.authenticated) {
						return BlocProvider(
							create: (context) => SignInBloc(
								userRepository: context.read<AuthenticationBloc>().userRepository,
							),
							child: SplashScreen(
								selectedTheme: selectedTheme,
								onThemeSelect: updateTheme,
							),
						);
					} else if (state.status == AuthenticationStatus.unauthenticated) {
						return StartScreen(
							selectedTheme: selectedTheme,
							onThemeSelect: updateTheme,
						);
					} else {
						return const Center(child: CircularProgressIndicator());
					}
				},
			),
		);
	}
}
