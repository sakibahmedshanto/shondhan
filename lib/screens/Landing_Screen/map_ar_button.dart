import 'package:flutter/material.dart';

class MapArButtons extends StatelessWidget {
  const MapArButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Discover your next home... ",
              style: TextStyle(
                fontSize:25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for Map View
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, color: Colors.white), // Optional icon
                    SizedBox(width: 5),
                    Text(
                      "Map View",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10), // Space between buttons
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for AR View
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.view_in_ar,
                        color: Colors.white), // Optional icon
                    SizedBox(width: 5),
                    Text(
                      "AR View",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
