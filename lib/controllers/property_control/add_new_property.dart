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

  // Method to submit property
  void submitProperty() async {
    try {
 
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
          utilitiesIncluded:["dummy utilities"],
          petFriendly: petFriendly.value,
          location: CustomPosition(longitude: 1, latitude: 1, timestamp: DateTime.now(), accuracy: 1, altitude: 1, altitudeAccuracy: 1, heading: 1, headingAccuracy: 1, speed: 1, speedAccuracy: 1),
          address: address.value,
          neighborhood: neighborhood.value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          description: description.value,
          nearbyFacilities: ["dummy facility1"],
          liked: false,
          ownerId: "dummyowner");

      // Add property to Firestore
      await firestore.collection('properties').add(property.toJson());
      print("Property submitted: ${propertyId.value}, ${buildingName.value}");

      // Optionally, you can reset the fields after submission
      resetFields();
    } catch (e) {
      print("Error submitting property: $e");
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
