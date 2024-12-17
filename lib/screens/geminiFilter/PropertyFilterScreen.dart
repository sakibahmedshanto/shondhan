import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shondhan/screens/geminiFilter/schema.dart';

import '../../models/property_model.dart';

class PropertyFilterScreen extends StatefulWidget {
  @override
  _PropertyFilterScreenState createState() => _PropertyFilterScreenState();
}

class _PropertyFilterScreenState extends State<PropertyFilterScreen> {
  List<Property> filteredProperties = [];
  bool isLoading = false;
  String userPrompt = ''; // The user's input prompt

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
    // Start the base query
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection('properties');

    // Check if each filter is not null and add to the query
    if (filters['bedroom'] != null) {
      query = query.where('bedroom', isEqualTo: filters['bedroom']);
    }
    if (filters['bathroom'] != null) {
      query = query.where('bathroom', isEqualTo: filters['bathroom']);
    }
    if (filters['price'] != null) {
      query = query.where('rentPrice', isEqualTo: filters['price']);
    }

    // Execute the query
    final QuerySnapshot snapshot = await query.get();

    // Convert the snapshot to a list of Property objects
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
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter your filter prompt'),
              onChanged: (value) {
                setState(() {
                  userPrompt = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: filterProperties,
              child: isLoading ? CircularProgressIndicator() : Text('Filter Properties'),
            ),
            SizedBox(height: 20),
            if (filteredProperties.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredProperties.length,
                  itemBuilder: (context, index) {
                    final property = filteredProperties[index];
                    return ListTile(
                      title: Text(property.buildingName),
                      subtitle: Text('Rent: \$${property.rentPrice}'),
                    );
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
