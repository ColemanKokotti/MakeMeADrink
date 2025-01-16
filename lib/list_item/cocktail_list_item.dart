import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';

class CocktailListItem extends StatelessWidget {
  final Cocktail cocktail;
  final bool isFavorite;
  final VoidCallback onTap;
  final Function(String) onFavoriteToggle;

  CocktailListItem(
      {required this.cocktail,
      required this.isFavorite,
      required this.onTap,
      required this.onFavoriteToggle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    cocktail.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 5),
                Flexible(
                  child: Text(
                    cocktail.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -5,
              right: 5,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.yellow : Colors.grey,
                ),
                onPressed: () {
                  onFavoriteToggle(cocktail.id);
                },
                iconSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
