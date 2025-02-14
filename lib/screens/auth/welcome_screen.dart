import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/screens/auth/sign_in_screen.dart';
import 'package:makemeadrink/screens/auth/sign_up_screen.dart';
import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatefulWidget {
	final String selectedTheme;
	final ValueChanged<String?> onThemeSelect;

	const WelcomeScreen({
		super.key,
		required this.selectedTheme,
		required this.onThemeSelect,
	});

	@override
	State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
	late TabController tabController;

	@override
	void initState() {
		super.initState();
		tabController = TabController(
			initialIndex: 0,
			length: 2,
			vsync: this,
		);
	}

	@override
	void dispose() {
		tabController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		final mediaQuery = MediaQuery.of(context);

		return Scaffold(
			backgroundColor: theme.colorScheme.surface,
			body: SingleChildScrollView(
				child: SizedBox(
					height: mediaQuery.size.height,
					child: Stack(
						children: [
							_buildDecorativeCircles(theme),
							BackdropFilter(
								filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
								child: Container(),
							),
							Column(
								children: [
									SizedBox(height: mediaQuery.size.height * 0.1),
									_buildLogoSection(mediaQuery),
									_buildAuthSection(mediaQuery, theme),
								],
							),
						],
					),
				),
			),
		);
	}

	Widget _buildDecorativeCircles(ThemeData theme) {
		return Stack(
			children: [
				Align(
					alignment: const AlignmentDirectional(20, -1.2),
					child: Container(
						height: MediaQuery.of(context).size.width,
						width: MediaQuery.of(context).size.width,
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							color: theme.colorScheme.tertiary,
						),
					),
				),
				Align(
					alignment: const AlignmentDirectional(-2.7, -1.2),
					child: Container(
						height: MediaQuery.of(context).size.width / 1.3,
						width: MediaQuery.of(context).size.width / 1.3,
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							color: theme.colorScheme.secondary,
						),
					),
				),
				Align(
					alignment: const AlignmentDirectional(2.7, -1.2),
					child: Container(
						height: MediaQuery.of(context).size.width / 1.3,
						width: MediaQuery.of(context).size.width / 1.3,
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							color: theme.colorScheme.primary,
						),
					),
				),
			],
		);
	}

	Widget _buildLogoSection(MediaQueryData mediaQuery) {
		return SizedBox(
			height: mediaQuery.size.height * 0.3,
			child: Center(
				child: Image.asset(
					'assets/images/startScreenImage.png',
					fit: BoxFit.contain,
				),
			),
		);
	}

	Widget _buildAuthSection(MediaQueryData mediaQuery, ThemeData theme) {
		return SizedBox(
			height: mediaQuery.size.height * 0.6,
			child: Column(
				children: [
					Padding(
						padding: const EdgeInsets.symmetric(horizontal: 20.0),
						child: TabBar(
							controller: tabController,
							unselectedLabelColor: theme.colorScheme.onSurface.withAlpha(128),
							labelColor: theme.colorScheme.onSurface,
							tabs: const [
								Padding(
									padding: EdgeInsets.all(8.0),
									child: Text(
										'Sign In',
										style: TextStyle(
											fontSize: 18,
											fontWeight: FontWeight.bold,
										),
									),
								),
								Padding(
									padding: EdgeInsets.all(8.0),
									child: Text(
										'Sign Up',
										style: TextStyle(
											fontSize: 18,
										),
									),
								),
							],
						),
					),
					Expanded(
						child: TabBarView(
							controller: tabController,
							children: [
								BlocProvider<SignInBloc>(
									create: (context) => SignInBloc(
										userRepository: context.read<AuthenticationBloc>().userRepository,
									),
									child: SignInScreen(
										selectedTheme: widget.selectedTheme,
										onThemeSelect: widget.onThemeSelect,
									),
								),
								BlocProvider<SignUpBloc>(
									create: (context) => SignUpBloc(
										userRepository: context.read<AuthenticationBloc>().userRepository,
									),
									child: SignUpScreen(
										selectedTheme: widget.selectedTheme,
										onThemeSelect: widget.onThemeSelect,
									),
								),
							],
						),
					),
				],
			),
		);
	}
}