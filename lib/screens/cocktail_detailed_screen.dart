import 'package:flutter/material.dart';
import 'package:makemeadrink/detailed_item/cocktail_detailed_widget.dart';

class CocktailDetailScreen extends StatelessWidget {
  final String id;

  const CocktailDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "How To Do The Drink",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      body: CocktailDetailWidget(id: id),
    );
  }
}
