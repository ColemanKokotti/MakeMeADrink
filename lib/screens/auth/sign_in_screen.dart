import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/screens/auth/components/my_text_field.dart';
import 'package:makemeadrink/screens/splash_screen.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
	final String selectedTheme;
	final ValueChanged<String?> onThemeSelect;

	const SignInScreen({
		Key? key,
		required this.selectedTheme,
		required this.onThemeSelect,
	}) : super(key: key);

	@override
	State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
	final passwordController = TextEditingController();
	final emailController = TextEditingController();
	final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = CupertinoIcons.eye_fill;
	bool obscurePassword = true;
	String? _errorMsg;

	@override
	void dispose() {
		passwordController.dispose();
		emailController.dispose();
		super.dispose();
	}

	void _handleSignInSuccess() {
		setState(() {
			signInRequired = false;
		});
		Navigator.pushReplacement(
			context,
			MaterialPageRoute(
				builder: (context) => SplashScreen(
					selectedTheme: widget.selectedTheme,
					onThemeSelect: widget.onThemeSelect,
				),
			),
		);
	}

	void _handleSignInProcess() {
		setState(() {
			signInRequired = true;
			_errorMsg = null;
		});
	}

	void _handleSignInFailure() {
		setState(() {
			signInRequired = false;
			_errorMsg = 'Invalid email or password';
		});
	}

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);

		return BlocListener<SignInBloc, SignInState>(
			listener: (context, state) {
				if (state is SignInSuccess) {
					_handleSignInSuccess();
				} else if (state is SignInProcess) {
					_handleSignInProcess();
				} else if (state is SignInFailure) {
					_handleSignInFailure();
				}
			},
			child: Form(
				key: _formKey,
				child: Column(
					children: [
						const SizedBox(height: 20),
						SizedBox(
							width: MediaQuery.of(context).size.width * 0.9,
							child: MyTextField(
									controller: emailController,
									hintText: 'Email',
									obscureText: false,
									keyboardType: TextInputType.emailAddress,
									prefixIcon: Icon(CupertinoIcons.mail_solid, color: theme.iconTheme.color),
									errorMsg: _errorMsg,
									validator: (val) {
										if (val!.isEmpty) {
											return 'Please fill in this field';
										} else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
											return 'Please enter a valid email';
										}
										return null;
									}
							),
						),
						const SizedBox(height: 10),
						SizedBox(
							width: MediaQuery.of(context).size.width * 0.9,
							child: MyTextField(
								controller: passwordController,
								hintText: 'Password',
								obscureText: obscurePassword,
								keyboardType: TextInputType.visiblePassword,
								prefixIcon: Icon(CupertinoIcons.lock_fill, color: theme.iconTheme.color),
								errorMsg: _errorMsg,
								validator: (val) {
									if (val!.isEmpty) {
										return 'Please fill in this field';
									} else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
										return 'Please enter a valid password';
									}
									return null;
								},
								suffixIcon: IconButton(
									onPressed: () {
										setState(() {
											obscurePassword = !obscurePassword;
											iconPassword = obscurePassword
													? CupertinoIcons.eye_fill
													: CupertinoIcons.eye_slash_fill;
										});
									},
									icon: Icon(iconPassword, color: theme.iconTheme.color),
								),
							),
						),
						const SizedBox(height: 20),
						if (!signInRequired)
							SizedBox(
								width: MediaQuery.of(context).size.width * 0.5,
								child: TextButton(
									onPressed: () {
										if (_formKey.currentState!.validate()) {
											context.read<SignInBloc>().add(
												SignInRequired(
														emailController.text,
														passwordController.text
												),
											);
										}
									},
									style: TextButton.styleFrom(
										elevation: 3.0,
										backgroundColor: theme.colorScheme.primary,
										foregroundColor: theme.colorScheme.onPrimary,
										shape: RoundedRectangleBorder(
												borderRadius: BorderRadius.circular(60)
										),
									),
									child: Padding(
										padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
										child: Text(
											'Sign In',
											textAlign: TextAlign.center,
											style: theme.textTheme.titleMedium?.copyWith(
												color: theme.colorScheme.onPrimary,
												fontWeight: FontWeight.w600,
											),
										),
									),
								),
							)
						else
							CircularProgressIndicator(color: theme.colorScheme.primary),
					],
				),
			),
		);
	}
}