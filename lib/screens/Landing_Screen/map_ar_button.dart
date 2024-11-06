import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/augmented/view_annotations.dart';

class MapArButtons extends StatelessWidget {
  const MapArButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Row(
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
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
               //add functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: const Row(
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
            const SizedBox(width: 10), // Space between buttons
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                    Get.to(()=>const ViewAnnotations());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: const Row(
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
