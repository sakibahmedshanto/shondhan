import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';

class ImageWidget extends StatelessWidget {
  final Property property;

  const ImageWidget({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("##,##,###", "en_INR");
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Container(
                height: 160,
                width: screenWidth,
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          CachedNetworkImageProvider(property.propertyImgs[0])),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      // child: Container(
                      //   height: 50.0,
                      //   width: 50.0,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white, // Replacing ColorConstant.kWhiteColor
                      //     borderRadius: BorderRadius.circular(18),
                      //   ),
                      //   child: const Icon(
                      //     Icons.favorite_border,
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "\$${oCcy.format(property.rentPrice)}",
                    style: GoogleFonts.notoSans(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      property.address,
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        color:
                            Colors.grey, // Replacing ColorConstant.kGreyColor
                      ),
                      overflow: TextOverflow.ellipsis, // For long addresses
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 12,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.buildingName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.bed, size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${property.bedroom} Bedrooms'),
                      const SizedBox(width: 16),
                      Icon(Icons.bathtub, size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${property.washroom} Bathrooms'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => ItemDetailScreen(property: property));
                        },
                        child: Text('View Details',
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
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
