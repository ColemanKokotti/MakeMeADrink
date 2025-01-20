import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';
import 'package:makemeadrink/screens/auth/welcome_screen.dart';
import 'package:makemeadrink/screens/cocktail_detailed_screen.dart';
import 'package:makemeadrink/list_item/cocktail_list_item.dart';
import 'package:makemeadrink/services/firebase_service.dart';
// Imports required packages, screens, and services.

class CocktailListScreen extends StatefulWidget {
  final List<Cocktail> cocktails;
  // Takes a list of cocktails as input.

  const CocktailListScreen({super.key, required this.cocktails});

  @override
  _CocktailListScreenState createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  late List<Cocktail> filteredCocktails;
  // Holds the filtered list of cocktails.

  List<String> favorites = [];
  // Stores the user's favorite cocktail IDs.

  TextEditingController searchController = TextEditingController();
  // Controls the search bar input.

  int _selectedIndex = 0;
  // Tracks the current bottom navigation tab.

  bool _showAlcoholic = true;
  bool _showNonAlcoholic = true;
  String _selectedCategory = 'All';
  // Tracks filter settings.

  final List<Color> screenBackgroundColor = [Colors.teal, Colors.blueGrey];
  // Gradient background colors.

  final FirebaseService _firebaseService = FirebaseService();
  // Firebase service for interacting with Firestore.

  @override
  void initState() {
    super.initState();
    filteredCocktails = widget.cocktails;
    // Initialize the filtered cocktail list with all cocktails.

    searchController.addListener(_filterCocktails);
    // Attach a listener to update filters when the search input changes.

    _loadFavorites();
    // Load favorite cocktails from Firestore.
  }

  Future<void> _loadFavorites() async {
    // Fetches favorite cocktail IDs from Firestore.
    List<String> userFavorites = await _firebaseService.getFavorites();
    setState(() {
      favorites = userFavorites;
    });
  }

  void _showFilterDialog() {
    // Opens a dialog for setting filters.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal,
          title: const Text('Filter Cocktails', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Alcohol content filters.
                    const Text('Alcohol Content:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    CheckboxListTile(
                      title: const Text('Alcoholic', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      value: _showAlcoholic,
                      onChanged: (bool? value) {
                        setState(() {
                          _showAlcoholic = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text('Non-Alcoholic', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      value: _showNonAlcoholic,
                      onChanged: (bool? value) {
                        setState(() {
                          _showNonAlcoholic = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    // Category filter dropdown.
                    const Text('Category:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      dropdownColor: Colors.teal,
                      items: [
                        'All',
                        'Cocktail',
                        'Shot',
                        'Coffee / Tea',
                        'Ordinary Drink',
                        'Shake',
                        'Punch / Party Drink',
                        'Cocoa',
                        'Homemade Liqueur',
                        'Beer',
                        'Other / Unknown',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            // Reset and apply filter buttons.
            TextButton(
              child: const Text('Reset', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {
                setState(() {
                  _showAlcoholic = true;
                  _showNonAlcoholic = true;
                  _selectedCategory = 'All';
                });
                _filterCocktails();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              onPressed: () {
                _filterCocktails();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _filterCocktails() {
    // Applies filters to the cocktail list.
    setState(() {
      final query = searchController.text.toLowerCase();
      filteredCocktails = widget.cocktails.where((cocktail) {
        final matchesQuery = cocktail.name.toLowerCase().contains(query);
        final matchesFavorites = _selectedIndex == 0 || favorites.contains(cocktail.id);
        final matchesAlcoholFilter = cocktail.isAlcoholic ? _showAlcoholic : _showNonAlcoholic;
        final matchesCategory = _selectedCategory == 'All' || cocktail.category == _selectedCategory;
        return matchesQuery && matchesFavorites && matchesAlcoholFilter && matchesCategory;
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    // Updates the bottom navigation tab and filters.
    setState(() {
      _selectedIndex = index;
      _filterCocktails();
    });
  }

  @override
  void dispose() {
    // Clean up resources.
    searchController.removeListener(_filterCocktails);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Builds the UI for the cocktail list screen.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(color: Colors.teal),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Drink Time'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
              ),
            ],
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
            // Search bar and filter button.
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: _showFilterDialog,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            // Display filtered cocktails in a grid.
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
                    onFavoriteToggle: (id) {
                      _firebaseService.toggleFavorite(id, !isFavorite);
                      _loadFavorites();
                    },
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
        backgroundColor: const Color.fromARGB(255, 196, 164, 132),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icon_list.png', height: 40, width: 40),
            label: 'Cocktails',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/cocktail_favorites_icon.png', height: 40, width: 40),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
