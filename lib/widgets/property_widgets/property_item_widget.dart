import 'package:flutter/material.dart';

import '../../models/property_model.dart';


class PropertyItemWidget extends StatelessWidget {
  final Property property;

  PropertyItemWidget({required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(property.flatImg),  // Display property image
        title: Text(property.buildingName),
        subtitle: Text('${property.rentPrice.toStringAsFixed(2)} USD per month'),
        trailing: Text(property.isAvailable ? 'Available' : 'Unavailable'),
        onTap: () {
          // Navigate to property detail page or take an action
        },
      ),
    );
  }
}
