import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../controllers/property_control/add_new_property.dart';
import '../../../widgets/property_widgets/dropdown_input.dart';
import '../../../widgets/property_widgets/text_input.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final AddPropertyController addPropertyController = Get.put(AddPropertyController());

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
    'Parking Space': false, // Added Parking Space under utilities
  };

  void _addImage() {
    if (_imageController.text.isNotEmpty) {
      setState(() {
        propertyImages.add(_imageController.text);
        _imageController.clear();
      });
    }
  }

  void _addVideo() {
    if (_videoController.text.isNotEmpty) {
      setState(() {
        propertyVideos.add(_videoController.text);
        _videoController.clear();
      });
    }
  }

  Future<void> _submitProperty() async {
    try {
      final propertyId = const Uuid().v4();
      final currentTime = DateTime.now().toIso8601String();
      final selectedUtilities = utilitiesIncluded.entries
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
        "liked": false, // Default to false
        "nearbyFacilities": [], // Placeholder, you can add UI to handle this
        "neighborhood": addPropertyController.neighborhood.value,
        "ownerId": const Uuid().v4(), // Auto-generate an owner ID
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
      };

      await FirebaseFirestore.instance.collection('properties').doc().set(propertyData);

      Get.snackbar('Success', 'Property submitted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit property: $e');
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInput(
              label: 'Building Name',
              onChanged: (value) => addPropertyController.buildingName.value = value,
            ),
            TextInput(
              label: 'Floor',
              isNumber: true,
              onChanged: (value) => addPropertyController.floor.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Rent Price',
              isNumber: true,
              onChanged: (value) => addPropertyController.rentPrice.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Size (sqft)',
              isNumber: true,
              onChanged: (value) => addPropertyController.sizeSqft.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Bedrooms',
              isNumber: true,
              onChanged: (value) => addPropertyController.bedroom.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Dining Space',
              isNumber: true,
              onChanged: (value) => addPropertyController.diningSpace.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Living Room',
              isNumber: true,
              onChanged: (value) => addPropertyController.livingRoom.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Kitchen',
              isNumber: true,
              onChanged: (value) => addPropertyController.kitchen.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Store Room',
              isNumber: true,
              onChanged: (value) => addPropertyController.storeRoom.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Veranda Space',
              isNumber: true,
              onChanged: (value) => addPropertyController.veranda.value = double.tryParse(value) ?? 0.0,
            ),
            TextInput(
              label: 'Washrooms',
              isNumber: true,
              onChanged: (value) => addPropertyController.washroom.value = double.tryParse(value) ?? 0.0,
            ),
            DropdownInput(
              label: 'Property Type',
              items: const ['Apartment', 'House', 'Condo', 'Villa'],
              onChanged: (value) => addPropertyController.propertyType.value = value ?? '',
            ),
            TextInput(
              label: 'Deposit Amount',
              isNumber: true,
              onChanged: (value) => addPropertyController.depositAmount.value = double.tryParse(value) ?? 0.0,
            ),
            DropdownInput(
              label: 'Lease Term',
              items: const ['6 Months', '1 Year', '2 Years'],
              onChanged: (value) => addPropertyController.leaseTerm.value = value ?? '',
            ),
            TextInput(
              label: 'Address',
              onChanged: (value) => addPropertyController.address.value = value,
            ),
            TextInput(
              label: 'Neighborhood',
              onChanged: (value) => addPropertyController.neighborhood.value = value,
            ),
            TextInput(
              label: 'Description',
              onChanged: (value) => addPropertyController.description.value = value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is Available'),
                Obx(
                  () => Switch(
                    value: addPropertyController.isAvailable.value,
                    onChanged: (value) {
                      addPropertyController.isAvailable.value = value;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Furnished'),
                Obx(
                  () => Switch(
                    value: addPropertyController.furnished.value,
                    onChanged: (value) {
                      addPropertyController.furnished.value = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Utilities Included'),
            const SizedBox(height: 10),
            Column(
              children: utilitiesIncluded.keys.map((utility) {
                return CheckboxListTile(
                  title: Text(utility),
                  value: utilitiesIncluded[utility],
                  onChanged: (value) {
                    setState(() {
                      utilitiesIncluded[utility] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            const Text('Add Images'),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addImage,
                ),
              ),
            ),
            Wrap(
              children: propertyImages
                  .map((img) => Chip(
                        label: Text(img),
                        onDeleted: () => setState(() => propertyImages.remove(img)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            const Text('Add Videos'),
            TextField(
              controller: _videoController,
              decoration: InputDecoration(
                labelText: 'Video URL',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addVideo,
                ),
              ),
            ),
            Wrap(
              children: propertyVideos
                  .map((vid) => Chip(
                        label: Text(vid),
                        onDeleted: () => setState(() => propertyVideos.remove(vid)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitProperty,
              child: const Text('Submit Property'),
            ),
          ],
        ),
      ),
    );
  }
}
