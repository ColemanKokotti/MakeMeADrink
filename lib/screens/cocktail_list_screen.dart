import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';
import 'package:makemeadrink/screens/cocktail_detailed_screen.dart';
import 'package:makemeadrink/list_item/cocktail_list_item.dart';

class CocktailListScreen extends StatefulWidget {
  final List<Cocktail> cocktails;

  const CocktailListScreen({super.key, required this.cocktails});

  @override
  _CocktailListScreenState createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  List<Cocktail> filteredCocktails = [];
  List<String> favorites = [];
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;

  final List<Color> screenBackgroundColor = [
    Colors.teal,
    Colors.blueGrey
  ];

  @override
  void initState() {
    super.initState();
    filteredCocktails = widget.cocktails;
    searchController.addListener(_filterCocktails);
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
      filteredCocktails = widget.cocktails.where((cocktail) {
        final matchesQuery = cocktail.name.toLowerCase().contains(query);
        final matchesFavorites = _selectedIndex == 0 || favorites.contains(cocktail.id);
        return matchesQuery && matchesFavorites;
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _filterCocktails();
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
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: screenBackgroundColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Drink Time'),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: screenBackgroundColor,
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
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          builder: (context) => CocktailDetailScreen(id: cocktail.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon_list.png', height: 50, width: 50),
            label: 'Cocktails',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/cocktail_favorites_icon.png', height: 50, width: 50),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
