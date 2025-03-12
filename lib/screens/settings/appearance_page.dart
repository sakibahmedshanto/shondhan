import 'package:flutter/material.dart';

class AppearancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appearance Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: false, // This should be bound to a state or a setting in your app.
            onChanged: (bool value) {
              // Implement the functionality to toggle dark mode here.
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
