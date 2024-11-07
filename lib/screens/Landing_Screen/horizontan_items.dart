import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';

class HorizontanItems extends StatelessWidget {
  const HorizontanItems({super.key, required this.property});
  final Property property;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
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
                    Get.to(()=>ItemDetailScreen(property: property));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(property.propertyImgs.isNotEmpty
                        ? property.propertyImgs[0]
                        : 'https://via.placeholder.com/220x140'), // Default image if no images are available
                  ),
                ),
              ),
            ],
          ),
          Text(
            property.buildingName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            children: [
              const Icon(Icons.location_on_rounded),
              Text(
                property.address,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
