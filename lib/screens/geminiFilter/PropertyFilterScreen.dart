import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shondhan/screens/Home/custom_widgets/image_widget.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../models/property_model.dart';
import '../Home/custom_widgets/RoundedSearchBox.dart';
import 'schema.dart';

class PropertyFilterScreen extends StatefulWidget {
  @override
  _PropertyFilterScreenState createState() => _PropertyFilterScreenState();
}

class _PropertyFilterScreenState extends State<PropertyFilterScreen> {
  List<Property> filteredProperties = [];
  bool isLoading = false;
  String userPrompt = ''; // The user's input prompt
  final TextEditingController _textController = TextEditingController();

  // Speech-to-Text variables
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _requestMicrophonePermission();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _requestMicrophonePermission() async {
    await Permission.microphone.request();
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "bn_BD",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      userPrompt = "$userPrompt ${result.recognizedWords}";
      _textController.text = userPrompt;
    });
  }

  // Function to send the user's prompt to Gemini and get structured data
  void filterProperties() async {
    setState(() {
      isLoading = true;
    });

    // Send the user's prompt to Gemini
    final response = await model.generateContent([Content.text(userPrompt)]);
    final responseData = response.text;

    if (responseData != null) {
      // Parse the response into structured data (e.g., Map)
      final Map<String, dynamic> structuredData = _parseResponse(responseData);

      // Use the structured data to filter properties from Firebase
      final filteredResults = await _filterPropertiesFromFirebase(structuredData);

      setState(() {
        filteredProperties = filteredResults;
        isLoading = false;
      });
    }
  }

  // Function to parse Gemini response (assuming it's a JSON-like string)
  Map<String, dynamic> _parseResponse(String responseData) {
    try {
      final Map<String, dynamic> parsedData = jsonDecode(responseData);
      return parsedData;
    } catch (e) {
      print("Error parsing response: $e");
      return {};
    }
  }

  // Function to filter properties from Firebase using the structured data
  Future<List<Property>> _filterPropertiesFromFirebase(Map<String, dynamic> filters) async {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('properties');

    if (filters['bedroom'] != null) {
      query = query.where('bedroom', isEqualTo: filters['bedroom']);
    }
    if (filters['bathroom'] != null) {
      query = query.where('bathroom', isEqualTo: filters['bathroom']);
    }
    if (filters['price'] != null) {
      query = query.where('rentPrice', isEqualTo: filters['price']);
    }

    final QuerySnapshot snapshot = await query.get();
    final List<Property> properties = snapshot.docs.map((doc) {
      return Property.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    return properties;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Properties'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child:  RoundedSearchBox(
            onChanged: (value) {
              setState(() {
                userPrompt = value;
              });
            },
          ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
                  tooltip: 'Listen',
                  backgroundColor: Colors.blueGrey,
                  child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: filterProperties,
              child: isLoading ? CircularProgressIndicator() : Text('Filter Properties'),
            ),
            const SizedBox(height: 20),
            if (filteredProperties.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProperties.length,
                  itemBuilder: (context, index) {
                    final property = filteredProperties[index];
                    return ImageWidget(property: property);
                  },
                ),
              )
            else if (isLoading)
              Center(child: CircularProgressIndicator())
            else
              Center(child: Text('No properties found with these filters')),
          ],
        ),
    ),
);
}
}















































// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// import '../../models/property_model.dart';
// import 'schema.dart';

// class PropertyFilterScreen extends StatefulWidget {
//   @override
//   _PropertyFilterScreenState createState() => _PropertyFilterScreenState();
// }

// class _PropertyFilterScreenState extends State<PropertyFilterScreen> {
//   List<Property> filteredProperties = [];
//   bool isLoading = false;
//   String userPrompt = ''; // The user's input prompt
//   final TextEditingController _textController = TextEditingController();

//   // Speech-to-Text variables
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;

//   @override
//   void initState() {
//     super.initState();
//     _initSpeech();
//     _requestMicrophonePermission();
//   }

//   void _initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   void _requestMicrophonePermission() async {
//     await Permission.microphone.request();
//   }

//   void _startListening() async {
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       listenFor: const Duration(seconds: 30),
//       localeId: "bn_BD",
//       cancelOnError: false,
//       partialResults: false,
//       listenMode: ListenMode.confirmation,
//     );
//     setState(() {});
//   }

//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   void _onSpeechResult(SpeechRecognitionResult result) {
//     setState(() {
//       userPrompt = "$userPrompt ${result.recognizedWords}";
//       _textController.text = userPrompt;
//     });
//   }

//   // Function to send the user's prompt to Gemini and get structured data
//   void filterProperties() async {
//     setState(() {
//       isLoading = true;
//     });

//     // Send the user's prompt to Gemini
//     final response = await model.generateContent([Content.text(userPrompt)]);
//     final responseData = response.text;

//     if (responseData != null) {
//       // Parse the response into structured data (e.g., Map)
//       final Map<String, dynamic> structuredData = _parseResponse(responseData);

//       // Use the structured data to filter properties from Firebase
//       final filteredResults = await _filterPropertiesFromFirebase(structuredData);

//       setState(() {
//         filteredProperties = filteredResults;
//         isLoading = false;
//       });
//     }
//   }

//   // Function to parse Gemini response (assuming it's a JSON-like string)
//   Map<String, dynamic> _parseResponse(String responseData) {
//     try {
//       final Map<String, dynamic> parsedData = jsonDecode(responseData);
//       return parsedData;
//     } catch (e) {
//       print("Error parsing response: $e");
//       return {};
//     }
//   }

//   // Function to filter properties from Firebase using the structured data
//   Future<List<Property>> _filterPropertiesFromFirebase(Map<String, dynamic> filters) async {
//     Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('properties');

//     if (filters['bedroom'] != null) {
//       query = query.where('bedroom', isEqualTo: filters['bedroom']);
//     }
//     if (filters['bathroom'] != null) {
//       query = query.where('bathroom', isEqualTo: filters['bathroom']);
//     }
//     if (filters['price'] != null) {
//       query = query.where('rentPrice', isEqualTo: filters['price']);
//     }

//     final QuerySnapshot snapshot = await query.get();
//     final List<Property> properties = snapshot.docs.map((doc) {
//       return Property.fromJson(doc.data() as Map<String, dynamic>);
//     }).toList();

//     return properties;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Filter Properties'),
//         backgroundColor: Colors.teal,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     decoration: InputDecoration(labelText: 'Enter your filter prompt'),
//                     onChanged: (value) {
//                       setState(() {
//                         userPrompt = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 FloatingActionButton.small(
//                   onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
//                   tooltip: 'Listen',
//                   backgroundColor: Colors.blueGrey,
//                   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: filterProperties,
//               child: isLoading ? CircularProgressIndicator() : Text('Filter Properties'),
//             ),
//             const SizedBox(height: 20),
//             if (filteredProperties.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: filteredProperties.length,
//                   itemBuilder: (context, index) {
//                     final property = filteredProperties[index];
//                     return ListTile(
//                       title: Text(property.buildingName),
//                       subtitle: Text('Rent: \$${property.rentPrice}'),
//                     );
//                   },
//                 ),
//               )
//             else if (isLoading)
//               Center(child: CircularProgressIndicator())
//             else
//               Center(child: Text('No properties found with these filters')),
//           ],
//         ),
//       ),
//     );
//   }
// }
