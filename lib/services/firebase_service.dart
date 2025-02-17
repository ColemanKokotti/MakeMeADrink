import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_state.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get _userId => _auth.currentUser?.uid ?? '';

  Future<List<String>> getFavorites() async {
    try {
      final doc = await _firestore.collection('users').doc(_userId).get();
      if (doc.exists) {
        List<dynamic> favorites = doc.data()?['favorites'] ?? [];
        return List<String>.from(favorites);
      }
      return [];
    } catch (e) {
      print("Error fetching favorites: $e");
      return [];
    }
  }

  Future<void> toggleFavorite(String cocktailId, bool isFavorite) async {
    try {
      final userRef = _firestore.collection('users').doc(_userId);
      if (isFavorite) {
        await userRef.update({
          'favorites': FieldValue.arrayUnion([cocktailId]),
        });
      } else {
        await userRef.update({
          'favorites': FieldValue.arrayRemove([cocktailId]),
        });
      }
    } catch (e) {
      print("Error updating favorites: $e");
    }
  }

  Future<void> saveThemeToFirebase(ThemeType theme) async {
    try {
      final userRef = _firestore.collection('users').doc(_userId);
      await userRef.set({
        'theme': theme.name,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error saving theme: $e");
    }
  }

  Future<ThemeType> getThemeFromFirebase() async {
    try {
      final doc = await _firestore.collection('users').doc(_userId).get();
      if (doc.exists) {
        final savedTheme = doc.data()?['theme'] ?? ThemeType.drink.name;
        return ThemeType.values.firstWhere(
              (e) => e.name == savedTheme,
          orElse: () => ThemeType.drink,
        );
      }
      return ThemeType.drink;
    } catch (e) {
      print("Error fetching theme: $e");
      return ThemeType.drink;
    }
  }
}
