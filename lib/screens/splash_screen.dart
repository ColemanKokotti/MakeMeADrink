import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';
import 'package:makemeadrink/screens/cocktail_list_screen.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_bloc.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final theme = themeState.themeData;

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor,
                  theme.primaryColorDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Drink Time',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(height: 20),
                  BlocListener<ThemeBloc, ThemeState>(
                    listener: (context, state) async {
                      try {
                        final data = await DefaultAssetBundle.of(context)
                            .loadString("assets/json/cocktails.json");
                        final List<dynamic> parsed = json.decode(data);
                        final cocktails = parsed.map((json) => Cocktail.fromJson(json)).toList();

                        await Future.delayed(const Duration(seconds: 3));

                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CocktailListScreen(
                                cocktails: cocktails,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Errore durante il caricamento dei dati: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
