import 'dart:convert';
import 'package:http/http.dart' as http;

class Cocktail {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;

  Cocktail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
  });


  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      imageUrl: json['strDrinkThumb'],
      ingredients: [],
    );
  }


  static Future<List<String>> fetchIngredientsFromApi(String cocktailId) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$cocktailId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final details = data['drinks'][0];
      List<String> ingredients = [];

      for (int i = 1; i <= 15; i++) {
        final ingredient = details['strIngredient$i'];
        final measure = details['strMeasure$i'];
        if (ingredient != null && ingredient.isNotEmpty) {
          ingredients.add(
              '${measure != null && measure.isNotEmpty ? measure : ''} $ingredient');
        }
      }
      return ingredients;
    } else {
      throw Exception('Failed to load ingredients');
    }
  }
}
