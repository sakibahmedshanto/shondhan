import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shondhan/models/property_model.dart';
import 'horizontan_items.dart'; // import the HorizontanItems widget

class HousesWidget extends StatelessWidget {
  HousesWidget({super.key});

  Future<List<Property>> _fetchProperties() async {
    try {
      // Fetch data from Firestore collection "properties"
      var snapshot =
          await FirebaseFirestore.instance.collection('properties').get();

      // Convert Firestore documents into Property model objects
      return snapshot.docs.map((doc) {
        return Property.fromJson(doc.data());
      }).toList();
    } catch (e) {
      print("Error fetching properties: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Property>>(
      future: _fetchProperties(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No properties available"));
        }

        List<Property> properties = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: properties.map((property) {
              return HorizontanItems(property: property);
            }).toList(),
          ),
        );
      },
    );
  }
}
