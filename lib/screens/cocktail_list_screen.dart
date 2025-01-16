import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';
import 'package:makemeadrink/screens/cocktail_detailed_screen.dart';
import 'package:makemeadrink/list_item/cocktail_list_item.dart';

class CocktailListScreen extends StatefulWidget {
  @override
  _CocktailListScreenState createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  List<Cocktail> cocktails = [];
  List<String> favorites = [];
  List<Cocktail> filteredCocktails = [];
  TextEditingController searchController = TextEditingController();
  final List<Color> backgrounColor = [
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 50, 205, 50),
    Color.fromARGB(255, 30, 144, 255)
  ];

  @override
  void initState() {
    super.initState();
    fetchCocktails();
    searchController.addListener(_filterCocktails);
  }

  Future<void> fetchCocktails() async {
    final data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/cocktails.json");
    final List<dynamic> parsed = json.decode(data);
    setState(() {
      cocktails = parsed.map((json) => Cocktail.fromJson(json)).toList();
      filteredCocktails = cocktails;
    });
  }

  void toggleFavorite(String id) {
    setState(() {
      if (favorites.contains(id)) {
        favorites.remove(id);
      } else {
        favorites.add(id);
      }
    });
  }

  void _filterCocktails() {
    setState(() {
      final query = searchController.text.toLowerCase();

      if (query.isEmpty) {
        filteredCocktails = cocktails;
      } else {
        filteredCocktails = cocktails.where((cocktail) {
          return cocktail.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCocktails);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: backgrounColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Drink Time'),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: backgrounColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search cocktails...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: filteredCocktails.length,
                  itemBuilder: (context, index) {
                    final cocktail = filteredCocktails[index];
                    final isFavorite = favorites.contains(cocktail.id);
                    return CocktailListItem(
                      cocktail: cocktail,
                      isFavorite: isFavorite,
                      onFavoriteToggle: toggleFavorite,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CocktailDetailScreen(id: cocktail.id),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
