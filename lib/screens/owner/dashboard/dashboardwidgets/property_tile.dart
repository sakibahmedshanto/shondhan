import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shondhan/models/property_model.dart';

class PropertyTile extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;

  PropertyTile({required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        title: Text(
          property.buildingName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'Price: \$${property.rentPrice}',
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 18),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: CachedNetworkImageProvider(
            property.propertyImgs.isNotEmpty ? property.propertyImgs[0] : 'default_image_url',
          ),
          child: property.propertyImgs.isEmpty
              ? Icon(Icons.image_not_supported, color: Colors.grey.shade400)
              : null,
        ),
        onTap: onTap,
      ),
    );
  }
}
