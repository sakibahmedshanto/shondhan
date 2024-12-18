import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:shondhan/utils/app-constant.dart';
import '../../models/property_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapViewScreen extends StatefulWidget {
  const MapViewScreen({Key? key}) : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polygon> _polygons = {};
  List<LatLng> _polygonPoints = [];
  final Location _locationService = Location();
  final LatLng _defaultLocation =
      const LatLng(23.946917253940256, 90.37751059937655); // Default to Gazipur
  BitmapDescriptor? _customMarkerIcon;
  bool _isHeatmapActive = false;
  final String _googleApiKey = "";
  LatLng? _lastClickedLocation;
  Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _loadCustomMarkerIcon();
    _checkLocationPermission();
    _loadPropertyMarkers();
  }

  Future<void> _loadCustomMarkerIcon() async {
    _customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)),
      'assets/images/home.png',
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _loadPropertyMarkers();
  }

  Future<void> _loadPropertyMarkers() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('properties').get();

      final markers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final property = Property.fromJson(data);

        return Marker(
          markerId: MarkerId(property.propertyId),
          position:
              LatLng(property.location.latitude, property.location.longitude),
          icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: property.buildingName,
            snippet: "${property.rentPrice} - ${property.propertyType}",
            onTap: () {
              _showPropertyDetails(property);
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
        _showErrorDialog(
            "Location service is disabled. Enable it to use the map features.");
        return;
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _showErrorDialog(
            "Location permission denied. Grant permission to use the map.");
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

  void _showPropertyDetails(Property property) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(property.buildingName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Price: ${property.rentPrice}"),
              Text("Type: ${property.propertyType}"),
              Text(
                  "Location: ${property.location.latitude}, ${property.location.longitude}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _addPolygonPoint(LatLng point) {
    setState(() {
      _polygonPoints.add(point);
      _polygons.add(Polygon(
        polygonId: const PolygonId('polygon_area'),
        points: _polygonPoints,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ));
    });
  }

  void _clearPolygon() {
    setState(() {
      _polygonPoints.clear();
      _polygons.clear();
    });
  }

void _clearcurrentlocation() {
  setState(() {
    // Remove the marker with the ID "seller_location"
    _markers.removeWhere((marker) => marker.markerId.value == "seller_location");
  });

  // Optionally, you could reset the map to the default location or do nothing
  _mapController?.animateCamera(CameraUpdate.newLatLngZoom(_defaultLocation, 12));
}

  void _clearPolygonAndNearbyPlaces() {
    setState(() {
      _polygonPoints.clear();
      _polygons.clear();
      _markers.clear();
      _circles.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Cleared all nearby places and polygon.")),
    );
  }

  Future<void> _searchPropertiesWithinPolygon() async {
    if (_polygonPoints.isEmpty) return;

    final List<Marker> markersWithinPolygon = [];
    final Polygon polygon = _polygons.first;

    for (final marker in _markers) {
      if (_isPointInPolygon(marker.position, polygon.points)) {
        markersWithinPolygon.add(marker);
      }
    }

    setState(() {
      _markers = markersWithinPolygon.toSet();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              "${markersWithinPolygon.length} properties found within the polygon")),
    );
  }

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersectCount = 0;
    for (int j = 0; j < polygon.length; j++) {
      LatLng p1 = polygon[j];
      LatLng p2 = polygon[(j + 1) % polygon.length];
      if (((p1.latitude > point.latitude) != (p2.latitude > point.latitude)) &&
          (point.longitude <
              (p2.longitude - p1.longitude) *
                      (point.latitude - p1.latitude) /
                      (p2.latitude - p1.latitude) +
                  p1.longitude)) {
        intersectCount++;
      }
    }
    return (intersectCount % 2) == 1;
  }

  void _toggleHeatmap() {
    setState(() {
      _isHeatmapActive = !_isHeatmapActive;
    });
  }
  Future<void> _searchLocation() async {
  TextEditingController searchController = TextEditingController();

  // Show a dialog to get the search input
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Search Location"),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: "Enter location name or address",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(searchController.text);
            },
            child: const Text("Search"),
          ),
        ],
      );
    },
  );

  // Get the search query from the user
  String searchQuery = searchController.text.trim();
  if (searchQuery.isEmpty) return;

  try {
    // Call the Geocoding API
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$searchQuery&key=$_googleApiKey');
    final response = await http.get(url);
    final data = json.decode(response.body);

    if (response.statusCode == 200 && data['status'] == 'OK') {
      // Get the coordinates of the first result
      final location = data['results'][0]['geometry']['location'];
      final double lat = location['lat'];
      final double lng = location['lng'];
      final LatLng searchedLocation = LatLng(lat, lng);

      // Move the map to the searched location
      setState(() {
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(searchedLocation, 15),
        );

        // Add a marker at the searched location
        _markers.add(Marker(
          markerId: const MarkerId("searched_location"),
          position: searchedLocation,
          infoWindow: InfoWindow(
            title: data['results'][0]['formatted_address'],
            snippet: "Searched Location",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
      });
    } else {
      _showErrorSnackBar("Location not found: ${data['status']}");
    }
  } catch (e) {
    _showErrorSnackBar("Error searching location: $e");
  }
}

void _showErrorSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

  Future<void> _fetchNearbyPlaces(LatLng location) async {
    const int radius = 500; // Search radius in meters
    const List<String> placeTypes = [
      'school',
      'college',
      'university',
      'hospital',
      'atm',
      'restaurant'
    ];

    // Custom icons for different place types
    final Map<String, BitmapDescriptor> customIcons = {
      'school': await _getCustomIcon('assets/images/school.png', 90),
      'college': await _getCustomIcon('assets/images/college.png', 90),
      'university': await _getCustomIcon('assets/images/university.png', 90),
      'hospital': await _getCustomIcon('assets/images/hospital.png', 90),
      'atm': await _getCustomIcon('assets/images/atm.png', 90),
      'restaurant': await _getCustomIcon('assets/images/restaurant.png', 90),
    };

    try {
      // Clear existing markers and circles
      setState(() {
        _markers.clear();
        _circles.clear();
      });

      // Add a blue circle for the search range
      setState(() {
        _circles.add(Circle(
          circleId: CircleId("search_range"),
          center: location,
          radius: radius.toDouble(),
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 2,
        ));
      });

      for (String type in placeTypes) {
        // Construct API URL
        final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
            '?location=${location.latitude},${location.longitude}'
            '&radius=$radius'
            '&type=$type'
            '&key=$_googleApiKey');

        // Make HTTP request
        final response = await http.get(url);
        debugPrint("Fetching places: $url");
        final data = json.decode(response.body);

        if (response.statusCode == 200) {
          if (data['status'] == 'OK') {
            final List<dynamic> results = data['results'];
            debugPrint("Fetched ${results.length} results for type: $type");

            for (var place in results) {
              final String name = place['name'];
              final double lat = place['geometry']['location']['lat'];
              final double lng = place['geometry']['location']['lng'];

              // Add marker for each place with a custom icon
              setState(() {
                _markers.add(Marker(
                  markerId: MarkerId('$name-$type'),
                  position: LatLng(lat, lng),
                  infoWindow: InfoWindow(
                    title: name,
                    snippet: 'Type: $type',
                  ),
                  icon: customIcons[type] ?? BitmapDescriptor.defaultMarker,
                ));
              });
            }
          } else {
            debugPrint(
                "Places API Error: ${data['status']} - ${data['error_message']}");
            _showErrorSnackBar(
                "API Error: ${data['error_message'] ?? data['status']}");
          }
        } else {
          debugPrint("Places API Response Error: ${response.statusCode}");
          _showErrorSnackBar("Error: Failed to fetch $type places.");
        }
      }

      // Success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nearby places loaded successfully.")),
      );
    } catch (e) {
      debugPrint("Exception fetching places: $e");
      _showErrorSnackBar("Exception: $e");
    }
  }

// Helper function to load custom icons from assets
  Future<BitmapDescriptor> _getCustomIcon(String assetPath, int size) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();

    final ui.Codec codec =
        await ui.instantiateImageCodec(bytes, targetWidth: size);
    final ui.FrameInfo fi = await codec.getNextFrame();
    final ByteData? byteData =
        await fi.image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      return BitmapDescriptor.defaultMarker;
    }

    return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }

  void _handleMapTap(LatLng tappedPoint) {
    setState(() {
      _lastClickedLocation = tappedPoint;

      // Clear previous markers except the tapped location
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId("clicked_location"),
        position: tappedPoint,
        infoWindow: const InfoWindow(title: "Selected Location"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });

    // Fetch nearby places for the tapped location
    _fetchNearbyPlaces(tappedPoint);

    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(tappedPoint, 15));
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map View",
        style: TextStyle(color: Colors.white), ),
        backgroundColor: AppConstant.appScendoryColor,
        actions: [
          IconButton(onPressed: _searchLocation, icon: const Icon(Icons.search,color:Colors.white)),
          IconButton(
            icon: const Icon(Icons.my_location,color:Colors.white),
            onPressed: () async {
              LocationData currentLocation =
                  await _locationService.getLocation();
              LatLng sellerLocation =
                  LatLng(currentLocation.latitude!, currentLocation.longitude!);

              setState(() {
                _markers.add(
                  Marker(
                    markerId: const MarkerId("seller_location"),
                    position: sellerLocation,
                    infoWindow: const InfoWindow(title: "Your Location"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                  ),
                );
              });

              _mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(sellerLocation, 15));
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear,color: Colors.white),
            onPressed: _clearcurrentlocation,
          ),
          
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _defaultLocation,
          zoom: 12,
        ),
        markers: _markers,
        circles: _circles, // Add this line
        polygons: _polygons,
        onTap: _handleMapTap,
        onMapCreated: (controller) => _mapController = controller,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "zoom_in",
            onPressed: () {
              _mapController?.animateCamera(CameraUpdate.zoomIn());
            },
            child: const Icon(Icons.zoom_in),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "zoom_out",
            onPressed: () {
              _mapController?.animateCamera(CameraUpdate.zoomOut());
            },
            child: const Icon(Icons.zoom_out),
          ),
          // const SizedBox(height: 10),
          // FloatingActionButton(
          //   heroTag: "clear_polygon",
          //   onPressed: _clearPolygon,
          //   child: const Icon(Icons.clear),
          // ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "toggle_heatmap",
            onPressed: _toggleHeatmap,
            child: Icon(_isHeatmapActive
                ? Icons.local_fire_department
                : Icons.thermostat_auto),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "clear_polygon_and_places",
            onPressed: _clearPolygonAndNearbyPlaces,
            child: const Icon(Icons.clear_all),
          ),
        ],
      ),
    );
  }
}
