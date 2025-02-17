import 'package:flutter/material.dart';
import 'package:makemeadrink/api_calls/cocktail_data.dart';
import 'package:makemeadrink/screens/auth/welcome_screen.dart';
import 'package:makemeadrink/screens/cocktail_detailed_screen.dart';
import 'package:makemeadrink/list_item/cocktail_list_item.dart';
import 'package:makemeadrink/screens/settings_screen.dart';
import 'package:makemeadrink/services/firebase_service.dart';


class CocktailListScreen extends StatefulWidget {
  final List<Cocktail> cocktails;

  const CocktailListScreen({
    super.key,
    required this.cocktails,
  });

  @override
  _CocktailListScreenState createState() => _CocktailListScreenState();
}

class _CocktailListScreenState extends State<CocktailListScreen> {
  late List<Cocktail> filteredCocktails;
  List<String> favorites = [];
  TextEditingController searchController = TextEditingController();
  int _selectedIndex = 0;
  bool _showAlcoholic = true;
  bool _showNonAlcoholic = true;
  String _selectedCategory = 'All';
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    filteredCocktails = widget.cocktails;
    searchController.addListener(_filterCocktails);
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<String> userFavorites = await _firebaseService.getFavorites();
    setState(() {
      favorites = userFavorites;
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Filter Cocktails',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.labelLarge?.color
            ),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alcohol Content:', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelLarge?.color)),
                    CheckboxListTile(
                      title: Text('Alcoholic', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelLarge?.color)),
                      value: _showAlcoholic,
                      onChanged: (bool? value) {
                        setState(() {
                          _showAlcoholic = value!;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Non-Alcoholic', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelLarge?.color)),
                      value: _showNonAlcoholic,
                      onChanged: (bool? value) {
                        setState(() {
                          _showNonAlcoholic = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Category:', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelLarge?.color)),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      isExpanded: true,
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
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
                        'Other / Unknown'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Theme.of(context).textTheme.labelLarge?.color)),
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
            TextButton(
              child: Text('Reset', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelLarge?.color)),
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
              child: Text('Apply', style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.labelLarge?.color)),
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(color: theme.appBarTheme.backgroundColor),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Drink Time'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout, color: theme.iconTheme.color),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.settings, color: theme.iconTheme.color),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
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
            colors: [theme.scaffoldBackgroundColor, theme.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search cocktails...',
                        prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                        filled: true,
                        fillColor: theme.primaryColor,
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
                      color: theme.appBarTheme.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.filter_list, color: theme.iconTheme.color),
                      onPressed: _showFilterDialog,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredCocktails.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_selectedIndex == 1 && favorites.isEmpty) ...[
                      Icon(Icons.favorite_border, size: 64, color: theme.iconTheme.color),
                      SizedBox(height: 16),
                      Text(
                        'Nessun cocktail preferito',
                        style: TextStyle(
                          fontSize: 20,
                          color: theme.textTheme.labelLarge?.color,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Aggiungi i tuoi cocktail preferiti toccando l\'icona del cuore',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.labelLarge?.color,
                        ),
                      ),
                    ] else ...[
                      Icon(Icons.search_off, size: 64, color: theme.primaryColor),
                      SizedBox(height: 16),
                      Text(
                        'Nessun cocktail trovato',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.labelLarge?.color,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Prova a modificare i filtri o il testo di ricerca',
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.textTheme.labelLarge?.color,
                        ),
                      ),
                    ],
                  ],
                ),
              )
                  : GridView.builder(
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
        backgroundColor: theme.appBarTheme.backgroundColor,
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
