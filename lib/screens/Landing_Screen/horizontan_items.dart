import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';

class HorizontanItems extends StatelessWidget {
  const HorizontanItems({super.key, required this.property});
  final Property property;

  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;

    // Define colors based on the theme
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final subtitleColor = isDarkMode ? Colors.grey[400] : Colors.black54;

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      width: 220,
      decoration: BoxDecoration(
        color: cardColor, // Apply dynamic card color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 140,
                child: InkWell(
                  onTap: () {
                    Get.to(() => ItemDetailScreen(property: property));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      property.propertyImgs.isNotEmpty
                          ? property.propertyImgs[0]
                          : 'https://via.placeholder.com/220x140', // Default image if no images are available
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            property.buildingName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: textColor, // Apply dynamic text color
                ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                color: subtitleColor, // Apply dynamic icon color
              ),
              const SizedBox(width: 4),
              Text(
                property.address,
                style: TextStyle(
                  color: subtitleColor, // Apply dynamic subtitle color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}