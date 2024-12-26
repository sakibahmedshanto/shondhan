import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart'; // For getting current location
import 'dart:async';

import '../../../models/custom_position_model.dart';


class LocationPicker extends StatefulWidget {
  final Function(CustomPosition) onLocationPicked;

  const LocationPicker({required this.onLocationPicked, Key? key}) : super(key: key);

  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  late GoogleMapController _mapController;
  LatLng? _selectedPosition;
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final userLocation = await _location.getLocation();
      setState(() {
        _selectedPosition = LatLng(userLocation.latitude ?? 0.0, userLocation.longitude ?? 0.0);
      });
      _mapController.animateCamera(CameraUpdate.newLatLng(_selectedPosition!));
    } catch (e) {
      print("Error fetching user location: $e");
    }
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _selectedPosition = position;
    });
  }

  void _onConfirmLocation() {
    if (_selectedPosition != null) {
      final customPosition = CustomPosition(
        longitude: _selectedPosition!.longitude,
        latitude: _selectedPosition!.latitude,
        timestamp: DateTime.now(),
        accuracy: 0.0, // Accuracy is unavailable here
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
      widget.onLocationPicked(customPosition);
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please wait for the location to load.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick a Location"),
        actions: [
          TextButton(
            onPressed: _onConfirmLocation,
            child: const Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: _selectedPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _selectedPosition!,
                zoom: 15,
              ),
              onTap: _onMapTapped,
              markers: {
                Marker(
                  markerId: MarkerId("selected"),
                  position: _selectedPosition!,
                ),
              },
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
    );
  }
}
