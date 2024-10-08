import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/property_model.dart';

class PropertyController extends GetxController {
  var properties = <Property>[].obs;  // Observable list of properties
  var isLoading = true.obs;  // Observable to track loading state

  // Fetch properties from Firestore
  Future<void> fetchProperties() async {
    try {
      isLoading(true);  // Start loading
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('properties')  // Your Firestore collection
          .orderBy('createdAt', descending: true)
          .limit(10)  // Load the first batch of 10 properties
          .get();

      // Parse the properties from Firestore documents
      properties.value = querySnapshot.docs.map((doc) {
        return Property.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load properties');
    } finally {
      isLoading(false);  // End loading
    }
  }

  // Pagination to fetch more properties as the user scrolls
  Future<void> fetchMoreProperties() async {
    if (!isLoading.value) {
      try {
        isLoading(true);
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('properties')
            .orderBy('createdAt', descending: true)
            .startAfter([properties.last.createdAt])  // Fetch after the last loaded property
            .limit(10)
            .get();

        var newProperties = querySnapshot.docs.map((doc) {
          return Property.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        // Append new properties to the existing list
        properties.addAll(newProperties);
      } catch (e) {
        Get.snackbar('Error', 'Failed to load more properties');
      } finally {
        isLoading(false);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchProperties();  // Fetch properties when controller is initialized
  }
}
