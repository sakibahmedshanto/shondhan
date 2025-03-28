import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/custom_position_model.dart';
import '../../models/property_model.dart';

class AddPropertyController extends GetxController {
  // Properties
  var propertyId = ''.obs;
  var buildingName = ''.obs;
  var floor = 0.0.obs;
  var rentPrice = 0.0.obs;
  var sizeSqft = 0.0.obs;
  var propertyImg = <String>[].obs;
  var propertyVideos = <String>[].obs; // New field for videos
  var bedroom = 0.0.obs;
  var diningSpace = 0.0.obs;
  var livingRoom = 0.0.obs; // New field for living room
  var kitchen = 0.0.obs; // New field for kitchen
  var storeRoom = 0.0.obs; // New field for store room
  var veranda = 0.0.obs;
  var washroom = 0.0.obs;
  var isAvailable = false.obs;
  var furnished = false.obs;
  var parkingSpace = false.obs;
  var propertyType = ''.obs;
  var depositAmount = 0.0.obs;
  var leaseTerm = ''.obs;
  var utilitiesIncluded = <String>[].obs;
  var petFriendly = false.obs;
  var address = ''.obs;
  var neighborhood = ''.obs;
  var description = ''.obs;
  var nearbyFacilities = <String>[].obs;

  // Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Firebase Authentication instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Method to validate all fields
  bool validateFields() {
    if (buildingName.value.isEmpty) {
      Get.snackbar("Validation Error", "Please enter the Building Name.");
      return false;
    }
    if (floor.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the Floor number.");
      return false;
    }
    if (rentPrice.value == 0.0) {
      Get.snackbar("Validation Error", "Please enter the Rent Price.");
      return false;
    }
    if (sizeSqft.value == 0.0) {
      Get.snackbar("Validation Error", "Please enter the Size in Sqft.");
      return false;
    }
    if (propertyImg.isEmpty) {
      Get.snackbar("Validation Error", "Please upload at least one property image.");
      return false;
    }
    if (bedroom.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the number of Bedrooms.");
      return false;
    }
    if (diningSpace.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the Dining Space.");
      return false;
    }
    if (livingRoom.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the Living Room space.");
      return false;
    }
    if (kitchen.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the Kitchen space.");
      return false;
    }
    if (storeRoom.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the Store Room space.");
      return false;
    }
    if (veranda.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the number of Verandas.");
      return false;
    }
    if (washroom.value == 0.0) {
      Get.snackbar("Validation Error", "Please specify the number of Washrooms.");
      return false;
    }
    if (propertyType.value.isEmpty) {
      Get.snackbar("Validation Error", "Please select a Property Type.");
      return false;
    }
    if (depositAmount.value == 0.0) {
      Get.snackbar("Validation Error", "Please enter the Deposit Amount.");
      return false;
    }
    if (leaseTerm.value.isEmpty) {
      Get.snackbar("Validation Error", "Please specify the Lease Term.");
      return false;
    }
    if (address.value.isEmpty) {
      Get.snackbar("Validation Error", "Please provide the Address.");
      return false;
    }
    if (neighborhood.value.isEmpty) {
      Get.snackbar("Validation Error", "Please provide the Neighborhood.");
      return false;
    }
    if (description.value.isEmpty) {
      Get.snackbar("Validation Error", "Please provide a Description.");
      return false;
    }
    return true; // All fields are valid
  }

  // Method to submit property
  void submitProperty() async {
    if (!validateFields()) return; // Validate before submission

    try {
      // Generate a random property ID
      String generatedPropertyId = firestore.collection('properties').doc().id;
      propertyId.value = generatedPropertyId;

      // Get the current user's UID
      User? user = auth.currentUser;
      if (user == null) {
        Get.snackbar("Error", "User not authenticated.");
        return;
      }
      String ownerId = user.uid;

      // Create Property object
      Property property = Property(
        propertyId: propertyId.value,
        buildingName: buildingName.value,
        floor: floor.value,
        rentPrice: rentPrice.value,
        sizeSqft: sizeSqft.value,
        propertyImgs: propertyImg,
        propertyVideos: propertyVideos, // New field for property videos
        bedroom: bedroom.value,
        diningSpace: diningSpace.value,
        livingRoom: livingRoom.value, // New field for living room
        kitchen: kitchen.value, // New field for kitchen
        storeRoom: storeRoom.value, // New field for store room
        veranda: veranda.value,
        washroom: washroom.value,
        isAvailable: isAvailable.value,
        furnished: furnished.value,
        parkingSpace: parkingSpace.value,
        propertyType: propertyType.value,
        depositAmount: depositAmount.value,
        leaseTerm: leaseTerm.value,
        utilitiesIncluded: utilitiesIncluded,
        petFriendly: petFriendly.value,
        location: CustomPosition(
          longitude: 1,
          latitude: 1,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 1,
          altitudeAccuracy: 1,
          heading: 1,
          headingAccuracy: 1,
          speed: 1,
          speedAccuracy: 1,
        ),
        address: address.value,
        neighborhood: neighborhood.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        description: description.value,
        nearbyFacilities: ["dummy facility1"],
        liked: false,
        ownerId: ownerId,
      );

      // Add property to Firestore
      await firestore.collection('properties').add(property.toJson());

      // Show success notification
      Get.snackbar("Success", "Property submitted successfully!");

      // Optionally reset fields and navigate back
      resetFields();
      Get.back(); // Exit the page
    } catch (e) {
      print("Error submitting property: $e");
      Get.snackbar("Error", "There was an error submitting the property.");
    }
  }

  // Method to reset the fields
  void resetFields() {
    propertyId.value = '';
    buildingName.value = '';
    floor.value = 0.0;
    rentPrice.value = 0.0;
    sizeSqft.value = 0.0;
    propertyImg.clear();
    propertyVideos.clear(); // Reset the property videos
    bedroom.value = 0.0;
    diningSpace.value = 0.0;
    livingRoom.value = 0.0;
    kitchen.value = 0.0;
    storeRoom.value = 0.0;
    veranda.value = 0.0;
    washroom.value = 0.0;
    isAvailable.value = false;
    furnished.value = false;
    parkingSpace.value = false;
    propertyType.value = '';
    depositAmount.value = 0.0;
    leaseTerm.value = '';
    utilitiesIncluded.clear();
    petFriendly.value = false;
    address.value = '';
    neighborhood.value = '';
    description.value = '';
  }
}
