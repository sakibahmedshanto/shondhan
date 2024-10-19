// import 'package:flutter/material.dart';
// import 'package:geo/annotations.dart';
// import 'package:geo/utils/annotation_data.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:math';  // For generating random UID

// class AddAnnotations extends StatefulWidget {
//   const AddAnnotations({super.key});

//   @override
//   State<AddAnnotations> createState() => _AddAnnotationsState();
// }

// class _AddAnnotationsState extends State<AddAnnotations> {
//   final TextEditingController _nameController = TextEditingController(); // For input text
//   Position? _currentPosition; // To hold the current position
//   String? _errorMessage; // For error handling

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation(); // Get current position when the screen loads
//   }

//   // Function to get current position using Geolocator
//   Future<void> _getCurrentLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       setState(() {
//         _currentPosition = position;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Error getting location: $e";
//       });
//     }
//   }

//   // Function to generate a random UID
//   String _generateRandomUid() {
//     final random = Random();
//     return random.nextInt(100000).toString(); // Generates a random number as UID
//   }

//   // Function to handle adding a new annotation
//   void _addAnnotation() {
//     if (_nameController.text.isEmpty || _currentPosition == null) {
//       // Display an error if fields are empty or position is not fetched yet
//       setState(() {
//         _errorMessage = "Please enter a name and ensure location is available.";
//       });
//       return;
//     }

//     // Create a new Annotation and add it to the list
//     final newAnnotation = Annotation(
//       uid: _generateRandomUid(),
//       position: _currentPosition!,
//       type: _nameController.text, // Set the user input as annotation type
//     );

//     setState(() {
//       AnnotationData.annotations.add(newAnnotation);
//       _errorMessage = null; // Clear any previous errors
//       _nameController.clear(); // Clear the input field after adding
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Annotation added successfully!"))
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Annotation'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Text input for the annotation name/type
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Annotation Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Display current location or a loading message
//             _currentPosition != null
//                 ? Text(
//                     'Current Position: \nLatitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
//                     textAlign: TextAlign.center,
//                   )
//                 : _errorMessage != null
//                     ? Text(_errorMessage!, style: const TextStyle(color: Colors.red))
//                     : const CircularProgressIndicator(),

//             const SizedBox(height: 20),

//             // Button to add the annotation
//             OutlinedButton(
//               onPressed: _addAnnotation,
//               child: const Text("Add Annotation"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
