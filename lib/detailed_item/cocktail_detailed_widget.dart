import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_detailed_api.dart';

class CocktailDetailWidget extends StatelessWidget {
  final String id;

  const CocktailDetailWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.blueGrey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: CocktailDetailService().fetchCocktailDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)),
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
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ingredients:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  ...ingredients.map((ingredient) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.brightness_1,
                            size: 8, color: Colors.white),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            ingredient,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 10),
                  const Text(
                    'Instructions:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    details['strInstructions'],
                    style: const TextStyle(fontSize: 16, color: Colors.white),
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
