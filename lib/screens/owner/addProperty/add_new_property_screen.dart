import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';
import '../../../controllers/property_control/add_new_property.dart';
import 'location_picker.dart';
import '../../../models/custom_position_model.dart';
import 'property_form.dart';

class AddPropertyScreen extends StatefulWidget {
  final String uId;
  AddPropertyScreen({super.key, required this.uId});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final AddPropertyController addPropertyController =
      Get.put(AddPropertyController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();

  final List<String> propertyImages = [];
  final List<String> propertyVideos = [];

  final Map<String, bool> utilitiesIncluded = {
    'Gas': false,
    'Water': false,
    'Electricity': false,
    'Lift': false,
    'Generator': false,
  };

  final Map<String, bool> nearbyFacilities = {
    'School': false,
    'Hospital': false,
    'Mosque': false,
    'Market': false,
    'Restaurant': false,
    'Park': false,
    'Gym': false,
    'Transport': false,
  };

  CustomPosition? _pickedLocation;

  bool _isValidUrl(String url) {
    final urlPattern = r'^(http|https):\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$';
    return RegExp(urlPattern).hasMatch(url);
  }

  void _addImage() {
    if (_imageController.text.isNotEmpty &&
        _isValidUrl(_imageController.text)) {
      setState(() {
        propertyImages.add(_imageController.text);
        _imageController.clear();
      });
    } else {
      Get.snackbar('Invalid URL', 'Please enter a valid image URL.');
    }
  }

  void _addVideo() {
    if (_videoController.text.isNotEmpty &&
        _isValidUrl(_videoController.text)) {
      setState(() {
        propertyVideos.add(_videoController.text);
        _videoController.clear();
      });
    } else {
      Get.snackbar('Invalid URL', 'Please enter a valid video URL.');
    }
  }

  Future<void> _submitProperty() async {
    if (!_formKey.currentState!.validate() || propertyImages.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields and add at least one image.',
      );
      return;
    }

    if (_pickedLocation == null) {
      Get.snackbar(
        'Location Error',
        'Please pick a location.',
      );
      return;
    }

    try {
      final propertyId = const Uuid().v4();
      final currentTime = DateTime.now().toIso8601String();
      final selectedUtilities = utilitiesIncluded.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();
      final selectedNearbyFacilities = nearbyFacilities.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      final propertyData = {
        "address": addPropertyController.address.value,
        "bedroom": addPropertyController.bedroom.value,
        "buildingName": addPropertyController.buildingName.value,
        "createdAt": currentTime,
        "depositAmount": addPropertyController.depositAmount.value,
        "description": addPropertyController.description.value,
        "diningSpace": addPropertyController.diningSpace.value,
        "livingRoom": addPropertyController.livingRoom.value,
        "kitchen": addPropertyController.kitchen.value,
        "storeRoom": addPropertyController.storeRoom.value,
        "floor": addPropertyController.floor.value,
        "furnished": addPropertyController.furnished.value,
        "isAvailable": addPropertyController.isAvailable.value,
        "leaseTerm": addPropertyController.leaseTerm.value,
        "liked": false,
        "nearbyFacilities": selectedNearbyFacilities,
        "neighborhood": addPropertyController.neighborhood.value,
        "ownerId": widget.uId,
        "petFriendly": addPropertyController.petFriendly.value,
        "propertyId": propertyId,
        "utilitiesIncluded": selectedUtilities,
        "propertyType": addPropertyController.propertyType.value,
        "rentPrice": addPropertyController.rentPrice.value,
        "sizeSqft": addPropertyController.sizeSqft.value,
        "updatedAt": currentTime,
        "propertyImgs": propertyImages,
        "propertyVideos": propertyVideos,
        "veranda": addPropertyController.veranda.value,
        "washroom": addPropertyController.washroom.value,
        "location": _pickedLocation?.toJson(),
        "parkingSpace": addPropertyController.parkingSpace.value,
      };

      // Add property to Firestore
      await FirebaseFirestore.instance
          .collection('properties')
          .doc(propertyId)
          .set(propertyData);

      Get.snackbar('Success', 'Property submitted successfully');

      // Navigate to ItemDetailScreen with the submitted property data
      final newProperty = Property.fromJson(propertyData);
      Get.to(() => ItemDetailScreen(property: newProperty));
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit property: $e');
    }
  }

  void _pickLocation() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LocationPicker(
          onLocationPicked: (location) {
            setState(() {
              _pickedLocation = location;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Property'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _pickLocation,
                child: Text(_pickedLocation == null
                    ? 'Pick Location'
                    : 'Location Picked'),
              ),
              PropertyForm(
                formKey: _formKey,
                addPropertyController: addPropertyController,
                imageController: _imageController,
                videoController: _videoController,
                propertyImages: propertyImages,
                propertyVideos: propertyVideos,
                utilitiesIncluded: utilitiesIncluded,
                nearbyFacilities: nearbyFacilities,
                addImage: _addImage,
                addVideo: _addVideo,
                submitProperty: _submitProperty,
              ),
            ],
          ),
        ));
  }
}