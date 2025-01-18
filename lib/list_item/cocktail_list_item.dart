import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';


class CocktailListItem extends StatefulWidget {
  final Cocktail cocktail;
  final bool isFavorite;
  final Function(String) onFavoriteToggle;
  final VoidCallback onTap;

  const CocktailListItem({
    super.key,
    required this.cocktail,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  _CocktailListItemState createState() => _CocktailListItemState();
}

class _CocktailListItemState extends State<CocktailListItem> {
  bool _isExpanded = false;
  final double _containerHeight = 200.0;
  final Duration _animationDuration = Duration(milliseconds: 300);
  late List<String> _ingredients = [];

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }


  Future<void> _loadIngredients() async {
    final ingredients = await Cocktail.fetchIngredientsFromApi(widget.cocktail.id);
    setState(() {
      _ingredients = ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: _toggleExpandedState,
      child: AnimatedContainer(
        duration: _animationDuration,
        height: _isExpanded ? 350.0 : _containerHeight,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Material(
          elevation: _isExpanded ? 10.0 : 5.0,
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.network(
                  widget.cocktail.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.cocktail.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_isExpanded && _ingredients.isNotEmpty)
                AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: _animationDuration,
                  child: Column(
                    children: _ingredients
                        .map((ingredient) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(Icons.brightness_1, size: 8),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              ingredient,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ))
                        .toList(),
                  ),
                )
              else
                IconButton(
                  icon: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: widget.isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => widget.onFavoriteToggle(widget.cocktail.id),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleExpandedState() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isExpanded = false;
        });
      });
    }
  }
}
