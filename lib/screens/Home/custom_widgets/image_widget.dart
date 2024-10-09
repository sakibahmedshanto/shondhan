import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';

class ImageWidget extends StatelessWidget {
  final Property property;

  ImageWidget(
    { 
    required this.property,
    }
  );

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("##,##,###", "en_INR");
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(()=>ItemDetailScreen(property: property) );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ItemDetailScreen(
            //       house,
            //       0,
            //       imageList,
            //     ),
            //   ),
            // );
          },
          child: Container(
            height: 160,
            width: screenWidth,
            padding:const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider( property.propertyImgs[0])
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white, // Replacing ColorConstant.kWhiteColor
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      Icons.favorite_border,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 15,
            bottom: 10,
          ),
          child: Row(
            children: <Widget>[
              Text(
                "\$" + oCcy.format(property.rentPrice),
                style: GoogleFonts.notoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  property.address,
                  style: GoogleFonts.notoSans(
                    fontSize: 15,
                    color: Colors.grey, // Replacing ColorConstant.kGreyColor
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
            top: 0,
            bottom: 10,
          ),
          child: Text(
            '${property.bedroom} bedrooms / ${property.washroom} bathrooms / ${property.sizeSqft} ft\u00B2',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
