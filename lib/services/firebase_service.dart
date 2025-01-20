import 'package:cloud_firestore/cloud_firestore.dart';
// Imports Firestore for database operations.

import 'package:firebase_auth/firebase_auth.dart';
// Imports FirebaseAuth for user authentication.

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Instance of FirebaseAuth for authentication.

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Instance of Firestore for database operations.

  String get _userId => _auth.currentUser?.uid ?? '';
  // Retrieves the current user's ID or returns an empty string if not logged in.

  Future<List<String>> getFavorites() async {
    // Fetches the list of favorite items for the current user.
    try {
      final doc = await _firestore.collection('users').doc(_userId).get();
      // Retrieves the user's document from the "users" collection.

      if (doc.exists) {
        List<dynamic> favorites = doc.data()?['favorites'] ?? [];
        // Extracts the 'favorites' field or an empty list if it doesn't exist.
        return List<String>.from(favorites);
        // Converts the list to a list of strings and returns it.
      }
      return [];
      // Returns an empty list if the document doesn't exist.
    } catch (e) {
      print("Error fetching favorites: $e");
      // Logs an error if something goes wrong.
      return [];
    }
  }

  Future<void> toggleFavorite(String cocktailId, bool isFavorite) async {
    // Adds or removes a cocktail from the user's favorites.
    try {
      final userRef = _firestore.collection('users').doc(_userId);
      // References the user's document in the "users" collection.

      if (isFavorite) {
        await userRef.update({
          'favorites': FieldValue.arrayUnion([cocktailId]),
          // Adds the cocktail ID to the 'favorites' array.
        });
      } else {
        await userRef.update({
          'favorites': FieldValue.arrayRemove([cocktailId]),
          // Removes the cocktail ID from the 'favorites' array.
        });
      }
    } catch (e) {
      print("Error updating favorites: $e");
      // Logs an error if something goes wrong.
    }
  }
}
