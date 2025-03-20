import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shondhan/provider/theme_provider.dart';
import 'package:shondhan/screens/settings/about_page.dart'; // Import AboutPage

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeProvider.toggleTheme(value);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            subtitle: const Text('App version, developer info'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
