import 'package:flutter/material.dart';
import 'appearance_page.dart';
import 'security_page.dart';
import 'about_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              // Add navigation to profile editing page or dialog
            },
          ),
          ListTile(
            leading: Icon(Icons.palette),
            title: Text('Appearance'),
            subtitle: Text('Theme, text size'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AppearancePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              // Add navigation to notifications settings page
            },
          ),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Security'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SecurityPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
        ],
      ),
    );
  }
}
