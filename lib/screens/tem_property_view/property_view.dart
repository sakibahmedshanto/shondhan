// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/property_model.dart';
// Import your Property model

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
        backgroundColor: Colors.blue, // Customize your app bar color
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('properties').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              Property property = Property.fromJson(propertyData.data() as Map<String, dynamic>);

              return Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the property image using CachedNetworkImage
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: property.propertyImg, // Use image URL from Property model
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 200, // Set a fixed height for the image
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(height: 8.0), // Spacing between image and text
                      // Display the rent price
                      Text(
                        'Rent Price: \$${property.rentPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0), // Spacing
                      // Display the address
                      Text(
                        property.address, // Display the address from Property model
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
