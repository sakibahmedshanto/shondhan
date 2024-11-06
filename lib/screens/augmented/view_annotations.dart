import 'package:ar_location_view/ar_location_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shondhan/screens/augmented/ar_property_widget.dart';
import '../../models/property_model.dart';
import 'annotations.dart';

class ViewAnnotations extends StatefulWidget {
  const ViewAnnotations({super.key});

  @override
  State<ViewAnnotations> createState() => _ViewAnnotationsState();
}

class _ViewAnnotationsState extends State<ViewAnnotations> {
  Future<List<Annotation>>? _cachedAnnotations;

  @override
  void initState() {
    super.initState();
    _cachedAnnotations = fetchAnnotations(); // Load data once on initialization
  }

  Future<List<Annotation>> fetchAnnotations() async {
    final snapshot = await FirebaseFirestore.instance.collection('properties').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      // Parse the data from Firestore into Property model
      final property = Property.fromJson(data);

      // Convert Property into Annotation for AR widget
      return Annotation(
        uid: property.propertyId,
        position: Position(
          latitude: property.location.latitude,
          longitude: property.location.longitude,
          timestamp: property.location.timestamp,
          accuracy: property.location.accuracy,
          altitude: property.location.altitude,
          heading: property.location.heading,
          speed: property.location.speed,
          altitudeAccuracy: 1,
          headingAccuracy: 1,
          speedAccuracy: 1,
        ),
        property: property,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Annotation>>(
      future: _cachedAnnotations, // Use the cached Future to prevent re-fetching
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No annotations found'));
        }

        final annotations = snapshot.data!;

        return MaterialApp(
          home: Scaffold(
            body: ArLocationWidget(
              annotations: annotations,
              showDebugInfoSensor: false,
              annotationViewBuilder: (context, annotation) {
                final castedAnnotation = annotation as Annotation;

                // Wrap the AR property widget in a Transform widget to scale it
                return Transform.scale(
                  scale: 1.5, // Adjust the scale factor to resize the annotation
                  child: ArPropertyWidget(
                    key: ValueKey(castedAnnotation.uid),
                    annotation: castedAnnotation,
                  ),
                );
              },
              onLocationChange: (Position position) {
                Future.delayed(const Duration(seconds: 5), () {
                  debugPrint("Latitude: ${position.latitude}");
                  debugPrint("Longitude: ${position.longitude}");
                });
              },
            ),
          ),
        );
      },
    );
  }
}
