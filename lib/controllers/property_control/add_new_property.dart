import 'package:cloud_firestore/cloud_firestore.dart';
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
  var propertyImg = ''.obs;
  var bedroom = 0.0.obs;
  var diningSpace = 0.0.obs;
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

  // Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method to validate all fields
  bool validateFields() {
    if (propertyId.value.isEmpty) {
      Get.snackbar("Validation Error", "Please enter a Property ID.");
      return false;
    }
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
    if (propertyImg.value.isEmpty) {
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
      // Create Property object
      Property property = Property(
        propertyId: propertyId.value,
        buildingName: buildingName.value,
        floor: floor.value,
        rentPrice: rentPrice.value,
        sizeSqft: sizeSqft.value,
        propertyImgs: [propertyImg.value],
        bedroom: bedroom.value,
        diningSpace: diningSpace.value,
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
        ownerId: "dummyowner",
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
    propertyImg.value = '';
    bedroom.value = 0.0;
    diningSpace.value = 0.0;
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
