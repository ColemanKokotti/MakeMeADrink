import 'package:makemeadrink/theme_bloc_providers/theme_state.dart';

abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeType theme;
  ThemeChanged(this.theme);
}
