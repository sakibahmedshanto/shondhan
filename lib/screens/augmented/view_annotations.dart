import 'package:ar_location_view/ar_location_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'annotation_view.dart';
import 'annotations.dart';
class ViewAnnotations extends StatefulWidget {
  const ViewAnnotations({super.key});
  @override
  State<ViewAnnotations> createState() => _ViewAnnotationsState();
}

List<Annotation> annotations = [
  Annotation(
    uid: "1",
    position: Position(
        longitude: 90.37895410094494,
        latitude: 23.947647708341872,
        timestamp: DateTime.now(),
        accuracy: 5.0,
        altitude: 100.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        speed: 0.0,
        speedAccuracy: 1.0),
    type: "Auditorium",
    imgdata: "assets/images/auditorium.jpeg",
  ),
  Annotation(
    uid: "3",
    position: Position(
        longitude: 90.37936294286327,
        latitude: 23.94754206207,
        timestamp: DateTime.now(),
        accuracy: 5.0,
        altitude: 100.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        speed: 0.0,
        speedAccuracy: 1.0),
    type: "Mosque",
    imgdata: "assets/images/mosque.jpeg",
  ),
  Annotation(
    uid: "4",
    position: Position(
        longitude: 90.37991041809084,
        latitude: 23.94725769093869,
        timestamp: DateTime.now(),
        accuracy: 5.0,
        altitude: 100.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        speed: 0.0,
        speedAccuracy: 1.0),
    type: "Five Pillars",
    imgdata: "assets/images/fivepillers.jpeg",
  ),
  Annotation(
    uid: "5",
    position: Position(
        longitude: 90.37970233336978,
        latitude: 23.947965647400196,
        timestamp: DateTime.now(),
        accuracy: 5.0,
        altitude: 100.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        speed: 0.0,
        speedAccuracy: 1.0),
    type: "Cafeteria",
    imgdata: "assets/images/cafeteria.jpeg",
  ),
  Annotation(
    uid: "6",
    position: Position(
        longitude: 90.37916062702843,
        latitude: 23.94805622756488,
        timestamp: DateTime.now(),
        accuracy: 5.0,
        altitude: 100.0,
        altitudeAccuracy: 1.0,
        heading: 0.0,
        headingAccuracy: 1.0,
        speed: 0.0,
        speedAccuracy: 1.0),
    type: "Administration Building",
    imgdata: "assets/images/adminbuilding.jpeg",
  ),
];

class _ViewAnnotationsState extends State<ViewAnnotations> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ArLocationWidget(
          annotations: annotations,
          showDebugInfoSensor: false,
          annotationViewBuilder: (context, annotation) {
            final castedAnnotation = annotation as Annotation;
            return AnnotationView(
              key: ValueKey(castedAnnotation.uid),
              imgAsset: castedAnnotation.imgdata, // Pass the image path here
              annotation: castedAnnotation,
            );
          },
          onLocationChange: (Position position) {
            Future.delayed(const Duration(seconds: 5), () {
              debugPrint("Latitude: " + position.latitude.toString());
              debugPrint("Longitude: " + position.longitude.toString());
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}
