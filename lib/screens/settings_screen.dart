import 'package:flutter/material.dart';
import 'package:makemeadrink/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  final String selectedTheme;
  final ValueChanged<String?> onThemeSelect;

  const SettingsScreen({
    super.key,
    required this.selectedTheme,
    required this.onThemeSelect,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String selectedTheme;

  @override
  void initState() {
    super.initState();
    selectedTheme = ThemeProvider.getCurrentTheme();
  }

  void _updateTheme(String? newTheme) {
    if (newTheme != null) {
      setState(() {
        selectedTheme = newTheme;
      });
      ThemeProvider.selectTheme(selectedTheme);
      widget.onThemeSelect(selectedTheme);
    }
  }

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
              onChanged: _updateTheme,
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