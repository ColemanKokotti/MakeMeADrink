import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_event.dart';
import 'package:makemeadrink/theme_bloc_providers/theme_state.dart';

import '../themes/default_theme.dart';
import '../themes/materialDesign_theme.dart';
import '../themes/neon_theme.dart';
import '../themes/pastel_theme.dart';
import '../themes/theme_dark.dart';
import '../themes/vintageRetro_theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(
    currentTheme: ThemeType.drink,
    themeData: defaultTheme,
  )) {
    on<ThemeChanged>(_onThemeChanged);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    final ThemeData newThemeData = _getThemeData(event.theme);
    emit(state.copyWith(
      currentTheme: event.theme,
      themeData: newThemeData,
    ));
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