import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/augmented/view_annotations.dart';
import 'package:shondhan/screens/mapView/map_view_screen.dart';

import '../geminiFilter/PropertyFilterScreen.dart';

class MapArButtons extends StatelessWidget {
  const MapArButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Discover your next home... ",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => MapViewScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
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
            const SizedBox(width: 10), // Space between buttons
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const ViewAnnotations());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
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
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() =>  PropertyFilterScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.view_in_ar,
                        color: Colors.white), // Optional icon
                    SizedBox(width: 5),
                    Text(
                      "AI Search",
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
