import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:shondhan/utils/app-constant.dart';
import '../../models/property_model.dart';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  final Location _locationService = Location();
  final LatLng _defaultLocation = const LatLng(23.946917253940256, 90.37751059937655); // Default to Gazipur
  BitmapDescriptor? _customMarkerIcon; // For the home icon marker

  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcon();
    _checkLocationPermission();
  }

  Future<void> _loadCustomMarkerIcon() async {
  _customMarkerIcon = await BitmapDescriptor.asset(
    const ImageConfiguration(size: Size(50, 50)), // Icon size
    'assets/images/home.png', // Path to your image
  );
}


  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _loadPropertyMarkers();
  }

  Future<void> _loadPropertyMarkers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('properties').get();

      final markers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final property = Property.fromJson(data);

        return Marker(
          markerId: MarkerId(property.propertyId),
          position: LatLng(property.location.latitude, property.location.longitude),
          icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker, // Use custom icon
          infoWindow: InfoWindow(
            title: property.buildingName,
            snippet: "${property.rentPrice} - ${property.propertyType}",
            onTap: () {
            //  shanto
            },
          ),
        );
      }).toSet();

      setState(() {
        _markers = markers;
      });
    } catch (e) {
      debugPrint("Error loading property markers: $e");
    }
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        _showErrorDialog("Location service is disabled. Enable it to use the map features.");
        return;
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _showErrorDialog("Location permission denied. Grant permission to use the map.");
        return;
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map View"),
        backgroundColor: AppConstant.appScendoryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () async {
              LocationData currentLocation = await _locationService.getLocation();
              LatLng sellerLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!);

              setState(() {
                _markers.add(
                  Marker(
                    markerId: const MarkerId("seller_location"),
                    position: sellerLocation,
                    infoWindow: const InfoWindow(title: "Your Location"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  ),
                );
              });

              _mapController?.animateCamera(CameraUpdate.newLatLngZoom(sellerLocation, 15));
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _defaultLocation,
          zoom: 12,
        ),
        markers: _markers,
        onMapCreated: _onMapCreated,
      ),
    );
  }
}
