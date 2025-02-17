import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/detailed_item/cocktail_detailed_widget.dart';
import '../theme_bloc_providers/theme_bloc.dart';
import '../theme_bloc_providers/theme_state.dart';

class CocktailDetailScreen extends StatelessWidget {
  final String id;

  const CocktailDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.appBarTheme.backgroundColor,
            title: Center(
              child: Text(
                "How To Do The Drink",
                style: TextStyle(
                  fontSize: 20,
                  color: theme.textTheme.labelLarge?.color ?? Colors.white,
                ),
              ),
            ),
          ),
          body: CocktailDetailWidget(id: id),
        );
      },
    );
  }
}