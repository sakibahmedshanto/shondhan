import 'package:flutter/material.dart';
import 'annotations.dart';

class AnnotationView extends StatelessWidget {
  const AnnotationView({
    Key? key,
    required this.annotation,
    required this.imgAsset,
  }) : super(key: key);

  final Annotation annotation;
  final String imgAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  annotation.type,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  '${annotation.distanceFromUser.toInt()} m',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              imgAsset,
              height: 50,
              width: 50,
              fit: BoxFit.cover, // Ensures the image is cropped properly
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.broken_image,
                  color: Colors.red,
                  size: 50,
                ); // Fallback if image fails to load
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget typeFactory(AnnotationType type) {
  //   IconData iconData = Icons.ac_unit_outlined;
  //   Color color = Colors.teal;
  //   switch (type) {
  //     case AnnotationType.pharmacy:
  //       iconData = Icons.local_pharmacy_outlined;
  //       color = Colors.red;
  //       break;
  //     case AnnotationType.hotel:
  //       iconData = Icons.hotel_outlined;
  //       color = Colors.green;
  //       break;
  //     case AnnotationType.library:
  //       iconData = Icons.library_add_outlined;
  //       color = Colors.blue;
  //       break;

  //     case AnnotationType.scl:
  //       iconData = Icons.library_add_outlined;
  //       color = Colors.blue;
  //       break;
  //   }
  //   return Icon(
  //     iconData,
  //     size: 40,
  //     color: color,
  //   );
  // }
}
