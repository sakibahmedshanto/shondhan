import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shondhan/screens/Home/custom_widgets/floating_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/image_widget.dart';
import 'package:shondhan/utils/app-constant.dart';
import '../../models/property_model.dart';

class HomePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(255, 255, 255, 20),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppConstant.appScendoryColor,
          title: Text(
            "Properties",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 20),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingWidget(
          leadingIcon: Icons.explore,
          txt: "Map view", // Removed key: key
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('properties').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error fetching properties"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("No properties available!"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final propertyData = snapshot.data!.docs[index];
                Property property = Property.fromJson(
                    propertyData.data() as Map<String, dynamic>);

                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ImageWidget(
                    property: property,
                  ),
                );
              },
            );
          },
        ));
  }
}
