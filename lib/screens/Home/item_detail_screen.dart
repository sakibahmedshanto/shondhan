import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/custom_widgets/floating_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/house_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/menu_widget.dart';
import 'package:shondhan/utils/app-constant.dart';

class ItemDetailScreen extends StatelessWidget {
  final Property property;

  const ItemDetailScreen({super.key, required this.property});

  // final List<String> houseArray = [
  //   "1,416",
  //   "4",
  //   "2",
  //   "2",
  //   "3",
  // ];
  // final List<String> typeArray = [
  //   "Square foot",
  //   "Bedrooms",
  //   "Bathrooms",
  //   "Garage",
  //   "Kitchen",
  // ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final oCcy = NumberFormat("#,##,###", "en_INR"); // Updated number format
    SystemChrome.setSystemUIOverlayStyle(
    const  SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Property Details",style: TextStyle(color: Colors.white),),backgroundColor: AppConstant.appScendoryColor,),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingWidget(
              leadingIcon: Icons.mail,
              txt: "Message",
            ),
            FloatingWidget(
              leadingIcon: Icons.phone,
              txt: "Call",
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:const EdgeInsets.only(top: 0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 0, bottom: 10),
                    child: SizedBox(
                      height: 200.0,
                      width: screenWidth,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                        ),
                        items: property.propertyImgs.map((imagePath) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: CachedNetworkImage(imageUrl: imagePath,)
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(top: 15, right: 15, left: 15),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       MenuWidget(
                  //         iconImg: Icons.arrow_back,
                  //         iconColor: Colors.white,
                  //         conBackColor: Colors.transparent,
                  //         onbtnTap: () {
                  //           Navigator.of(context).pop(false);
                  //         },
                  //       ),
                  //       MenuWidget(
                  //         iconImg: Icons.favorite_border,
                  //         iconColor: Colors.white,
                  //         conBackColor: Colors.transparent,
                  //         onbtnTap: () {
                  //           Color.fromRGBO(255, 0, 0, 10);
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$'+ oCcy.format(property.rentPrice),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            property.address,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        height: 45,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "20 hours ago",
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                child: Text(
                  "House Information",
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                  height: 120,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                        HouseWidget(number: property.sizeSqft.ceil().toString(), type: "Size"),
                        HouseWidget(number: property.bedroom.ceil().toString(), type: "Bedroom"),
                        HouseWidget(number: property.washroom.ceil().toString(), type: "Washroom"),
                        HouseWidget(number: property.veranda.ceil().toString(), type: "Varanda"),
                        HouseWidget(number: property.diningSpace.ceil().toString(), type: "Dining Space"),
                        ],
                      ))),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 20),
                child: Text(
                  "Flawless 2 story on a family-friendly cul-de-sac in the heart of Blue Valley! Walk in to an open floor plan flooded with daylight, formal dining private office, screened-in lanai with fireplace, TV hookup & custom heaters that overlooks the lit basketball court.",
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.notoSans(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
