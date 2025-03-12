import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shondhan/models/property_model.dart';

class PropertyTile extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;

  PropertyTile({required this.property, required this.onTap});

  @override
Widget build(BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.deepPurple.withOpacity(0.15),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              /// **Property Image with Soft Shadow & Rounded Effect**
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: property.propertyImgs.isNotEmpty
                        ? property.propertyImgs[0]
                        : 'default_image_url',
                    width: 65,
                    height: 65,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.image_not_supported, color: Colors.grey.shade400, size: 26),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              /// **Property Details - Elegant, Clean, and Structured**
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.buildingName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 0.2,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Price: \$${property.rentPrice}',
                      style: TextStyle(
                        fontSize: 14.5,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              /// **Luxury Forward Arrow with Floating Effect**
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
