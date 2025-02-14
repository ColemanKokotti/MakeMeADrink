import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final String selectedTheme;
  final ValueChanged<String?> onThemeSelect;

  const SettingsScreen({
    Key? key,
    required this.selectedTheme,
    required this.onThemeSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: theme.textTheme.labelLarge),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedTheme,
              onChanged: (newTheme) {
                onThemeSelect(newTheme);
              },
              style: TextStyle(
                color: theme.textTheme.labelLarge?.color,
                fontSize: theme.textTheme.labelLarge?.fontSize,
              ),
              iconEnabledColor: theme.iconTheme.color,
              dropdownColor: theme.scaffoldBackgroundColor,
              items: <String>['default', 'light', 'dark', 'pastel', 'vintage', 'neon']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(value.toUpperCase()),
                      SizedBox(width: 15),
                      if (value == selectedTheme)
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
  }
}