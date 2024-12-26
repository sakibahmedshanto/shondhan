import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/property_control/add_new_property.dart';
import '../../../widgets/property_widgets/dropdown_input.dart';
import '../../../widgets/property_widgets/text_input.dart';

class PropertyForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final AddPropertyController addPropertyController;
  final TextEditingController imageController;
  final TextEditingController videoController;
  final List<String> propertyImages;
  final List<String> propertyVideos;
  final Map<String, bool> utilitiesIncluded;
  final Map<String, bool> nearbyFacilities;
  final VoidCallback addImage;
  final VoidCallback addVideo;
  final Future<void> Function() submitProperty;

  PropertyForm({
    required this.formKey,
    required this.addPropertyController,
    required this.imageController,
    required this.videoController,
    required this.propertyImages,
    required this.propertyVideos,
    required this.utilitiesIncluded,
    required this.nearbyFacilities,
    required this.addImage,
    required this.addVideo,
    required this.submitProperty,
  });

  @override
  _PropertyFormState createState() => _PropertyFormState();
}

class _PropertyFormState extends State<PropertyForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Building Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) =>
                widget.addPropertyController.buildingName.value = value,
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
            onChanged: (value) => widget.addPropertyController.floor.value =
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
            onChanged: (value) => widget.addPropertyController.rentPrice.value =
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
            onChanged: (value) => widget.addPropertyController.sizeSqft.value =
                double.tryParse(value) ?? 0.0,
            validator: (value) => value == null || value.isEmpty
                ? 'Size (sqft) is required'
                : null,
          ),
          TextInput(
            label: 'Bedrooms',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.bedroom.value =
                double.tryParse(value) ?? 0.0,
          ),
          TextInput(
            label: 'Washrooms',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.washroom.value =
                double.tryParse(value) ?? 0.0,
          ),
          TextInput(
            label: 'Dining Space',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.diningSpace.value =
                double.tryParse(value) ?? 0.0,
          ),
          TextInput(
            label: 'Living Room',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.livingRoom.value =
                double.tryParse(value) ?? 0.0,
          ),
          TextInput(
            label: 'Kitchen',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.kitchen.value =
                double.tryParse(value) ?? 0.0,
          ),
          TextInput(
            label: 'Store Room',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.storeRoom.value =
                double.tryParse(value) ?? 0.0,
          ),
          TextInput(
            label: 'Veranda Space',
            isNumber: true,
            onChanged: (value) => widget.addPropertyController.veranda.value =
                double.tryParse(value) ?? 0.0,
          ),
          DropdownInput(
            label: 'Property Type',
            items: const ['Apartment', 'House', 'Condo', 'Villa'],
            onChanged: (value) =>
                widget.addPropertyController.propertyType.value = value ?? '',
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Deposit Amount',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => widget.addPropertyController.depositAmount.value =
                double.tryParse(value) ?? 0.0,
            validator: (value) => value == null || value.isEmpty
                ? 'Deposit Amount is required'
                : null,
          ),
          const SizedBox(height: 10),
          DropdownInput(
            label: 'Lease Term',
            items: const ['6 Months', '1 Year', '2 Years'],
            onChanged: (value) =>
                widget.addPropertyController.leaseTerm.value = value ?? '',
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) =>
                widget.addPropertyController.address.value = value,
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
                widget.addPropertyController.neighborhood.value = value,
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
                widget.addPropertyController.description.value = value,
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
                      value: widget.addPropertyController.isAvailable.value,
                      onChanged: (value) {
                        widget.addPropertyController.isAvailable.value = value;
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
                  const Text('Parking Space'),
                  Obx(
                    () => Switch(
                      value: widget.addPropertyController.parkingSpace.value,
                      onChanged: (value) {
                        widget.addPropertyController.parkingSpace.value = value;
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
                      value: widget.addPropertyController.furnished.value,
                      onChanged: (value) {
                        widget.addPropertyController.furnished.value = value;
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
                      value: widget.addPropertyController.petFriendly.value,
                      onChanged: (value) {
                        widget.addPropertyController.petFriendly.value = value;
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
            children: widget.utilitiesIncluded.keys.map((utility) {
              return CheckboxListTile(
                title: Text(utility),
                value: widget.utilitiesIncluded[utility],
                onChanged: (value) {
                  setState(() {
                    widget.utilitiesIncluded[utility] = value ?? false;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('Nearby Facilities'),
          const SizedBox(height: 10),
          Column(
            children: widget.nearbyFacilities.keys.map((facility) {
              return CheckboxListTile(
                title: Text(facility),
                value: widget.nearbyFacilities[facility],
                onChanged: (value) {
                  setState(() {
                    widget.nearbyFacilities[facility] = value ?? false;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          const Text('Add Images'),
          TextFormField(
            controller: widget.imageController,
            decoration: InputDecoration(
              labelText: 'Image URL',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: widget.addImage,
              ),
            ),
            validator: (value) => widget.propertyImages.isEmpty
                ? 'At least one image is required'
                : null,
          ),
          Wrap(
            children: widget.propertyImages
                .map((img) => Chip(
                      label: Text(img),
                      onDeleted: () => setState(() {
                        widget.propertyImages.remove(img);
                      }),
                    ))
                .toList(),
          ),
          const SizedBox(height: 10),
          const Text('Add Videos'),
          TextFormField(
            controller: widget.videoController,
            decoration: InputDecoration(
              labelText: 'Video URL',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.add),
                onPressed: widget.addVideo,
              ),
            ),
            validator: (value) => widget.propertyVideos.isEmpty
                ? 'At least one video is required'
                : null,
          ),
          const SizedBox(height: 10),
          Wrap(
            children: widget.propertyVideos
                .map((vid) => Chip(
                      label: Text(vid),
                      onDeleted: () => setState(() {
                        widget.propertyVideos.remove(vid);
                      }),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: widget.submitProperty,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text(
                'Submit Property',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}