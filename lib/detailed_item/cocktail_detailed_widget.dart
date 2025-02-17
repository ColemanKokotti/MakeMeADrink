import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_detailed_api.dart';

class CocktailDetailWidget extends StatelessWidget {
  final String id;

  const CocktailDetailWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: CocktailDetailService().fetchCocktailDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(color: theme.textTheme.labelLarge?.backgroundColor)),
            );
          } else {
            final details = snapshot.data!;
            final ingredients =
            CocktailDetailService().getIngredients(details);
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Image.network(
                    details['strDrinkThumb'],
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    details['strDrink'],
                    style: TextStyle(
                        fontSize: 24,
                        color: theme.textTheme.labelLarge?.backgroundColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Ingredients:',
                    style: TextStyle(
                        fontSize: 20,
                        color: theme.textTheme.labelLarge?.backgroundColor),
                  ),
                  const SizedBox(height: 5),
                  ...ingredients.map((ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Icon(Icons.brightness_1,
                            size: 8, color: theme.iconTheme.color),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            ingredient,
                            style: TextStyle(
                                fontSize: 16, color: theme.textTheme.labelLarge?.backgroundColor),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 10),
                  Text(
                    'Instructions:',
                    style: TextStyle(
                        fontSize: 20,
                        color: theme.textTheme.labelLarge?.backgroundColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    details['strInstructions'],
                    style: TextStyle(fontSize: 16, color: theme.textTheme.labelLarge?.backgroundColor),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
