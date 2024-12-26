import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
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
  loc.Location _location = loc.Location();
  TextEditingController _searchController = TextEditingController();

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

  Future<void> _searchLocation() async {
    try {
      List<Location> locations = await locationFromAddress(_searchController.text);
      if (locations.isNotEmpty) {
        final location = locations.first;
        final position = LatLng(location.latitude, location.longitude);
        _mapController.animateCamera(CameraUpdate.newLatLng(position));
        setState(() {
          _selectedPosition = position;
        });
      }
    } catch (e) {
      print("Error searching location: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location not found.")),
      );
    }
  }

  void _zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void _zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _selectedPosition == null
              ? const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 166, 125, 238))) // Purple loading indicator
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
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (value) {
                      _searchLocation();
                    },
                    decoration: InputDecoration(
                      hintText: "Search location",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.purple),
                    ),
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            right: 10,
            child: FloatingActionButton(
              heroTag: 'myLocationBtn',
              backgroundColor: Colors.deepPurple[300],
              onPressed: _getUserLocation,
              child: Icon(Icons.my_location, color: Colors.white),
            ),
          ),
         
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              heroTag: 'confirmLocationBtn',
              onPressed: _onConfirmLocation,
              backgroundColor: Colors.deepPurple[300],
              child: Icon(Icons.check, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}