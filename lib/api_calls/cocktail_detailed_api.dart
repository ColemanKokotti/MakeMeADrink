import 'dart:convert';
import 'package:http/http.dart' as http;

class CocktailDetailService {
  Future<Map<String, dynamic>> fetchCocktailDetails(String id) async {
    final response = await http.get(Uri.parse(
        'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['drinks'][0];
    } else {
      throw Exception('Failed to load cocktail details');
    }
  }

  List<String> getIngredients(Map<String, dynamic> details) {
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
  }
}
