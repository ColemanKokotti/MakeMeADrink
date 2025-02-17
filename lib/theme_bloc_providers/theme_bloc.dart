import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_event.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_state.dart';
import '../services/firebase_service.dart';
import '../themes/default_theme.dart';
import '../themes/materialDesign_theme.dart';
import '../themes/neon_theme.dart';
import '../themes/pastel_theme.dart';
import '../themes/theme_dark.dart';
import '../themes/vintageRetro_theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ThemeBloc() : super(ThemeState(
    currentTheme: ThemeType.drink,
    themeData: defaultTheme,
  )) {
    on<ThemeChanged>(_onThemeChanged);
    _loadThemeFromFirebase();
  }

  Future<void> _loadThemeFromFirebase() async {
    try {
      final doc = await _firestore.collection('settings').doc('theme').get();
      if (doc.exists) {
        final savedTheme = doc['theme'] ?? ThemeType.drink.name;
        final themeType = ThemeType.values.firstWhere(
              (e) => e.name == savedTheme,
          orElse: () => ThemeType.drink,
        );
        final newThemeData = _getThemeData(themeType);
        emit(state.copyWith(currentTheme: themeType, themeData: newThemeData));
      }
    } catch (e) {
      print('Errore nel caricamento del tema: $e');
    }
  }

  Future<void> _saveThemeToFirebase(ThemeType theme) async {
    try {
      await _firestore.collection('settings').doc('theme').set({
        'theme': theme.name,
      });
    } catch (e) {
      print('Errore nel salvataggio del tema: $e');
    }
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    final ThemeData newThemeData = _getThemeData(event.theme);
    emit(state.copyWith(currentTheme: event.theme, themeData: newThemeData));
    final firebaseService = FirebaseService();
    firebaseService.saveThemeToFirebase(event.theme);
  }

  ThemeData _getThemeData(ThemeType theme) {
    switch (theme) {
      case ThemeType.light:
        return materialDesignTheme;
      case ThemeType.dark:
        return darkTheme;
      case ThemeType.pastel:
        return pastelTheme;
      case ThemeType.neon:
        return neonFuturisticTheme;
      case ThemeType.vintage:
        return vintageRetroTheme;
      case ThemeType.drink:
        return defaultTheme;
    }
  }
}
