import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/property_control/add_new_property.dart';
import '../../../widgets/property_widgets/dropdown_input.dart';
import '../../../widgets/property_widgets/text_input.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final AddPropertyController addPropertyController = Get.put(AddPropertyController());

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
              label: 'Property Image URL',
              onChanged: (value) => addPropertyController.propertyImg.value = value,
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
              items: ['Apartment', 'House', 'Condo', 'Villa'],
              onChanged: (value) => addPropertyController.propertyType.value = value ?? '',
            ),
            TextInput(
              label: 'Deposit Amount',
              isNumber: true,
              onChanged: (value) => addPropertyController.depositAmount.value = double.tryParse(value) ?? 0.0,
            ),
            DropdownInput(
              label: 'Lease Term',
              items: ['6 Months', '1 Year', '2 Years'],
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
            // Availability
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Is Available'),
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
            // Furnished
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Furnished'),
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
            // Parking Space
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Parking Space'),
                Obx(
                  () => Switch(
                    value: addPropertyController.parkingSpace.value,
                    onChanged: (value) {
                      addPropertyController.parkingSpace.value = value;
                    },
                  ),
                ),
              ],
            ),
            // Pet Friendly
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pet Friendly'),
                Obx(
                  () => Switch(
                    value: addPropertyController.petFriendly.value,
                    onChanged: (value) {
                      addPropertyController.petFriendly.value = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addPropertyController.submitProperty,
              child: const Text('Submit Property'),
            ),
          ],
        ),
      ),
    );
  }
}
