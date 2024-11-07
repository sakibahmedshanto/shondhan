import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';
import 'package:shondhan/screens/owner/dashboard/dashboardwidgets/property_tile.dart';
import '../../../../models/user-model.dart';

class PropertyListWidget extends StatelessWidget {
  final UserModel userModel;

  const PropertyListWidget({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _propertyStream(userModel.uId), // Stream for real-time updates
      builder: (context, AsyncSnapshot<List<Property>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Loading indicator
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error loading properties."));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No properties found."));
        }

        List<Property> properties = snapshot.data!;

        return ListView.builder(
          itemCount: properties.length,
          itemBuilder: (context, index) {
            var property = properties[index];
            return Dismissible(
              key: Key(property.propertyId),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                // Query the document(s) where `propertyId` matches
                var querySnapshot = await FirebaseFirestore.instance
                    .collection('properties')
                    .where('propertyId', isEqualTo: property.propertyId)
                    .get();

                // Loop through the results and delete each document
                for (var doc in querySnapshot.docs) {
                  await doc.reference.delete();
                }

                // Show a confirmation snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Property deleted successfully')),
                );
              },
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: PropertyTile(
                property: property,
                onTap: () {
                  Get.to(() => ItemDetailScreen(property: property));
                },
              ),
            );
          },
        );
      },
    );
  }

  // Stream to fetch properties in real-time for a given user ID
  Stream<List<Property>> _propertyStream(String userId) {
    return FirebaseFirestore.instance
        .collection('properties')
        .where('ownerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Property.fromJson(doc.data())).toList());
  }
}
