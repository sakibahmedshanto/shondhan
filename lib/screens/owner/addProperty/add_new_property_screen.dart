import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:shondhan/models/property_model.dart';
import 'package:shondhan/screens/Home/item_detail_screen.dart';
import '../../../controllers/property_control/add_new_property.dart';
import '../../../widgets/property_widgets/dropdown_input.dart';
import '../../../widgets/property_widgets/text_input.dart';

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
        "location": {
          "longitude": 1,
          "latitude": 1,
          "timestamp": currentTime,
          "accuracy": 1,
          "altitude": 1,
          "altitudeAccuracy": 1,
          "heading": 1,
          "headingAccuracy": 1,
          "speed": 1,
          "speedAccuracy": 1,
        },
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Property'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Building Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      addPropertyController.buildingName.value = value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Building Name is required'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Floor',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => addPropertyController.floor.value =
                      double.tryParse(value) ?? 0.0,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Floor is required'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Rent Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => addPropertyController.rentPrice.value =
                      double.tryParse(value) ?? 0.0,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Rent Price is required'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Size (sqft)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => addPropertyController.sizeSqft.value =
                      double.tryParse(value) ?? 0.0,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Size (sqft) is required'
                      : null,
                ),
                TextInput(
                  label: 'Bedrooms',
                  isNumber: true,
                  onChanged: (value) => addPropertyController.bedroom.value =
                      double.tryParse(value) ?? 0.0,
                ),
                TextInput(
                  label: 'Washrooms',
                  isNumber: true,
                  onChanged: (value) => addPropertyController.washroom.value =
                      double.tryParse(value) ?? 0.0,
                ),
                TextInput(
                  label: 'Dining Space',
                  isNumber: true,
                  onChanged: (value) => addPropertyController
                      .diningSpace.value = double.tryParse(value) ?? 0.0,
                ),
                TextInput(
                  label: 'Living Room',
                  isNumber: true,
                  onChanged: (value) => addPropertyController.livingRoom.value =
                      double.tryParse(value) ?? 0.0,
                ),
                TextInput(
                  label: 'Kitchen',
                  isNumber: true,
                  onChanged: (value) => addPropertyController.kitchen.value =
                      double.tryParse(value) ?? 0.0,
                ),
                TextInput(
                  label: 'Store Room',
                  isNumber: true,
                  onChanged: (value) => addPropertyController.storeRoom.value =
                      double.tryParse(value) ?? 0.0,
                ),
                TextInput(
                  label: 'Veranda Space',
                  isNumber: true,
                  onChanged: (value) => addPropertyController.veranda.value =
                      double.tryParse(value) ?? 0.0,
                ),
                DropdownInput(
                  label: 'Property Type',
                  items: const ['Apartment', 'House', 'Condo', 'Villa'],
                  onChanged: (value) =>
                      addPropertyController.propertyType.value = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Deposit Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => addPropertyController
                      .depositAmount.value = double.tryParse(value) ?? 0.0,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Deposit Amount is required'
                      : null,
                ),
                const SizedBox(height: 10),
                DropdownInput(
                  label: 'Lease Term',
                  items: const ['6 Months', '1 Year', '2 Years'],
                  onChanged: (value) =>
                      addPropertyController.leaseTerm.value = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      addPropertyController.address.value = value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Address is required'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Neighborhood',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      addPropertyController.neighborhood.value = value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Neighborhood information is required'
                      : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      addPropertyController.description.value = value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Description is required'
                      : null,
                ),
                Column(
                  children: [
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
                            activeColor:
                                Colors.purple, // Thumb color when active
                            activeTrackColor: Colors
                                .purple.shade200, // Track color when active
                            inactiveThumbColor:
                                Colors.white, // Thumb color when inactive
                            inactiveTrackColor: Colors
                                .grey.shade300, // Track color when inactive
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Parking Space'),
                        Obx(
                          () => Switch(
                            value: addPropertyController.parkingSpace.value,
                            onChanged: (value) {
                              addPropertyController.parkingSpace.value = value;
                            },
                            activeColor: Colors.purple,
                            activeTrackColor: Colors.purple.shade200,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade300,
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
                            activeColor: Colors.purple,
                            activeTrackColor: Colors.purple.shade200,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Pet Friendly'),
                        Obx(
                          () => Switch(
                            value: addPropertyController.petFriendly.value,
                            onChanged: (value) {
                              addPropertyController.petFriendly.value = value;
                            },
                            activeColor: Colors.purple,
                            activeTrackColor: Colors.purple.shade200,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.shade300,
                          ),
                        ),
                      ],
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
                const SizedBox(height: 20),
                const Text('Nearby Facilities'),
                const SizedBox(height: 10),
                Column(
                  children: nearbyFacilities.keys.map((facility) {
                    return CheckboxListTile(
                      title: Text(facility),
                      value: nearbyFacilities[facility],
                      onChanged: (value) {
                        setState(() {
                          nearbyFacilities[facility] = value ?? false;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                const Text('Add Images'),
                TextFormField(
                  controller: _imageController,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _addImage,
                    ),
                  ),
                  validator: (value) => propertyImages.isEmpty
                      ? 'At least one image is required'
                      : null,
                ),
                Wrap(
                  children: propertyImages
                      .map((img) => Chip(
                            label: Text(img),
                            onDeleted: () =>
                                setState(() => propertyImages.remove(img)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 10),
                const Text('Add Videos'),
                TextFormField(
                  controller: _videoController,
                  decoration: InputDecoration(
                    labelText: 'Video URL',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _addVideo,
                    ),
                  ),
                  validator: (value) => propertyVideos.isEmpty
                      ? 'At least one video is required'
                      : null,
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: propertyVideos
                      .map((vid) => Chip(
                            label: Text(vid),
                            onDeleted: () =>
                                setState(() => propertyVideos.remove(vid)),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitProperty,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.purple, // Button color set to purple
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle:
                          const TextStyle(fontSize: 16), // Optional text style
                    ),
                    child: const Text(
                      'Submit Property',
                      style: TextStyle(
                          color: Colors.white), // Text color set to white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
