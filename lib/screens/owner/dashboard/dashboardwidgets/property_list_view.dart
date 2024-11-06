import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shondhan/models/property_model.dart';

import '../../../../models/user-model.dart';

class PropertyListWidget extends StatelessWidget {
  final UserModel userModel;

  const PropertyListWidget({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchProperties(userModel.uId), // Fetch properties based on the user ID
      builder: (context, AsyncSnapshot<List<Property>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading indicator
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
                // Delete the property from Firestore
                await FirebaseFirestore.instance
                    .collection('properties')
                    .doc(property.propertyId)
                    .delete();
                
                // Show a confirmation snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Property deleted successfully')),
                );
              },
              background: Container(
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: ListTile(
                title: Text(property.buildingName),
                subtitle: Text('Price: ${property.rentPrice}'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Handle property tap, maybe show more details
                },
              ),
            );
          },
        );
      },
    );
  }

  // Function to fetch properties for a given user ID
  Future<List<Property>> _fetchProperties(String userId) async {
    try {
      var propertiesSnapshot = await FirebaseFirestore.instance
          .collection('properties')
          .where('ownerId', isEqualTo: userId)
          .get();

      return propertiesSnapshot.docs
          .map((doc) => Property.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching properties: $e');
      return [];
    }
  }
}
