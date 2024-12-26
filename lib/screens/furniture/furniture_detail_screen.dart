// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, prefer_const_declarations, deprecated_member_use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../../models/furniture_model.dart';
import '../../utils/app-constant.dart';

class FurnitureDetailScreen extends StatefulWidget {
  FurnitureModel furnitureModel;
  FurnitureDetailScreen({super.key, required this.furnitureModel});

  @override
  State<FurnitureDetailScreen> createState() => _FurnitureDetailScreenState();
}

class _FurnitureDetailScreenState extends State<FurnitureDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppConstant.appScendoryColor,
        title: Text(
          "Product Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 60,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ModelViewer(
                backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                src: widget.furnitureModel.reality,
                ar: true,
                arPlacement: ArPlacement.floor,
                autoRotate: true,
                cameraControls: true,
                disableZoom: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.furnitureModel.productName),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            widget.furnitureModel.isSale == true &&
                                    widget.furnitureModel.salePrice != ''
                                ? Text(
                                    "BDT: " + widget.furnitureModel.salePrice,
                                  )
                                : Text(
                                    "BDT: " + widget.furnitureModel.fullPrice,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Category: " + widget.furnitureModel.categoryName,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.furnitureModel.productDescription,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            child: Container(
                              width: Get.width / 3.0,
                              height: Get.height / 16,
                              decoration: BoxDecoration(
                                color: AppConstant.appScendoryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextButton(
                                child: Text(
                                  "WhatsApp",
                                  style: TextStyle(
                                      color: AppConstant.appTextColor),
                                ),
                                onPressed: () {
                                  sendMessageOnWhatsApp(
                                    widget.furnitureModel.ownerPhoneNumber,
                                    "Hello Furnihub \n I want to know about this product \n ${widget.furnitureModel.productName} \n ${widget.furnitureModel.productId}",
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Material(
                            child: Container(
                              width: Get.width / 3.0,
                              height: Get.height / 16,
                              decoration: BoxDecoration(
                                color: AppConstant.appScendoryColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: TextButton(
                                child: Text(
                                  "Call",
                                  style: TextStyle(
                                      color: AppConstant.appTextColor),
                                ),
                                onPressed: () {
                                  makePhoneCall(widget.furnitureModel.ownerPhoneNumber);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

static Future<void> sendMessageOnWhatsApp(String phoneNumber, String message) async {
  final whatsappScheme = 'whatsapp://send?text=${Uri.encodeComponent(message)}';
  final whatsappWeb = 'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

  // Check if the device has WhatsApp installed
  if (await canLaunch(whatsappScheme)) {
    await launch(whatsappScheme);
  } else if (await canLaunch(whatsappWeb)) {
    await launch(whatsappWeb);
  } else {
    // Show an error if WhatsApp cannot be launched
    Get.snackbar(
      'Error',
      'WhatsApp is not installed or cannot be launched. Please install WhatsApp and try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}



  static Future<void> makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not place the call');
    }
  }
}
