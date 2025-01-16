import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_detailed_api.dart';

class CocktailDetailWidget extends StatelessWidget {
  final String id;

  const CocktailDetailWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: CocktailDetailService().fetchCocktailDetails(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final details = snapshot.data!;
          final ingredients = CocktailDetailService().getIngredients(details);
          return Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Image.network(
                  details['strDrinkThumb'],
                  height: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text(
                  details['strDrink'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text('Ingredients:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                ...ingredients.map((ingredient) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(Icons.brightness_1, size: 8),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(ingredient,
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    )),
                SizedBox(height: 10),
                Text('Instructions:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(details['strInstructions'],
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }
      },
    );
  }
}
