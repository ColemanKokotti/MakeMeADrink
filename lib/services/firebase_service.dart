import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user's ID
  String get _userId => _auth.currentUser?.uid ?? '';

  // Method to get the user's favorite cocktails from Firestore
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

  // Method to add/remove a favorite cocktail
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
}
