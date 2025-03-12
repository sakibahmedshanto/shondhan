import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Implement password change functionality.
            },
          ),
          SwitchListTile(
            title: Text('Enable Two-Factor Authentication'),
            value: false, // This should be bound to a state or a setting in your app.
            onChanged: (bool value) {
              // Implement the functionality to toggle two-factor authentication here.
            },
          ),
        ],
      ),
    );
  }
}
