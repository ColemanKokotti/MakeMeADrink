import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme_bloc_providers/theme_bloc.dart';
import '../theme_bloc_providers/theme_event.dart';
import '../theme_bloc_providers/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings', style: theme.textTheme.labelLarge),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<ThemeType>(
                  value: state.currentTheme,
                  onChanged: (ThemeType? newTheme) {
                    if (newTheme != null) {
                      context.read<ThemeBloc>().add(ThemeChanged(newTheme));
                    }
                  },
                  style: TextStyle(
                    color: theme.textTheme.labelLarge?.color,
                    fontSize: theme.textTheme.labelLarge?.fontSize,
                  ),
                  iconEnabledColor: theme.iconTheme.color,
                  dropdownColor: theme.scaffoldBackgroundColor,
                  items: ThemeType.values.map<DropdownMenuItem<ThemeType>>((ThemeType type) {
                    return DropdownMenuItem<ThemeType>(
                      value: type,
                      child: Row(
                        children: [
                          Text(type.name.toUpperCase()),
                          SizedBox(width: 15),
                          if (type == state.currentTheme)
                            Icon(
                              Icons.circle_rounded,
                              color: theme.iconTheme.color,
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
