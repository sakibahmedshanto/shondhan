import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';
import 'annotations.dart';

class ArPropertyWidget extends StatelessWidget {
  const ArPropertyWidget({
    super.key,
    required this.annotation,
  });

  final Annotation annotation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            spreadRadius: 1.5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: InkWell(
        onTap:(){
          Get.to(()=>ItemDetailScreen(property: annotation.property));
        },
        child: Row(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: annotation.property.propertyImgs.isNotEmpty
                    ? annotation.property.propertyImgs[0]
                    : '', // Use first image or empty if not available
                height: 50,
                width: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  height: 50,
                  width: 40,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.broken_image,
                  color: Colors.red,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(width: 12),
        
            // Property Details Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    annotation.property.buildingName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${annotation.property.bedroom.toDouble().ceil()} Bedrooms',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    '${annotation.distanceFromUser.toInt()} m away',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
