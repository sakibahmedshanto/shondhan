import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shondhan/provider/theme_provider.dart';

class AppearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the ThemeProvider from the provider
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: themeProvider.themeMode == ThemeMode.dark, // Use provider's state to set the switch's position
            onChanged: (bool value) {
              themeProvider.toggleTheme(value); // Toggle the theme on change
            },
          ),
          ListTile(
            title: Text('Text Size'),
            subtitle: Text('Normal'),
            onTap: () {
              // Open a dialog or another screen to select text size.
            },
          ),
        ],
      ),
    );
  }
}
