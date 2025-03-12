import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shondhan - Find Your Perfect Home',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              'Developed by: Team Hexagon',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Contact: hexagonteam21@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'About the App:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Shondhan helps users find and list properties with ease. '
              'It provides advanced search, AR view, and personalized recommendations.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Technologies Used:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '• Flutter & Dart\n'
              '• Firebase for authentication & database\n'
              '• Google Maps API for property locations\n'
              '• AI-powered recommendations',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'License & Terms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'By using this app, you agree to our terms and conditions. '
              'All rights reserved © 2025 Shondhan.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
