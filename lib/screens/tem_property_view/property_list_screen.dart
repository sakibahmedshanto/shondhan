import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/property_control/propertry_controller.dart';
import '../../widgets/property_widgets/property_item_widget.dart';


class PropertyListScreen extends StatelessWidget {
  final PropertyController propertyController = Get.put(PropertyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Properties'),
      ),
      body: Obx(() {
        if (propertyController.isLoading.value && propertyController.properties.isEmpty) {
          // Show a loading indicator while fetching data
          return Center(child: CircularProgressIndicator());
        } else if (propertyController.properties.isEmpty) {
          // Show a message if no properties were found
          return Center(child: Text('No properties available'));
        } else {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  !propertyController.isLoading.value) {
                // Load more properties when the user scrolls to the bottom
                propertyController.fetchMoreProperties();
              }
              return false;
            },
            child: ListView.builder(
              itemCount: propertyController.properties.length,
              itemBuilder: (context, index) {
                var property = propertyController.properties[index];
                return PropertyItemWidget(property: property);  // A widget to display each property
              },
            ),
          );
        }
      }),
    );
  }
}
