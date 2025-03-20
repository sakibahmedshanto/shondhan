import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../../../models/property_model.dart';

class RentPredictionWidget extends StatefulWidget {
  final Property property;

  const RentPredictionWidget({Key? key, required this.property}) : super(key: key);

  @override
  _RentPredictionWidgetState createState() => _RentPredictionWidgetState();
}

class _RentPredictionWidgetState extends State<RentPredictionWidget> {
  late Future<double> _predictedRentPrice;

  @override
  void initState() {
    super.initState();
    _predictedRentPrice = fetchRentPrediction(widget.property);
  }

  Future<double> fetchRentPrediction(Property property) async {
    final response = await http.post(
      Uri.parse('https://houserentprice.onrender.com/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Location': property.address,
        'Area': property.sizeSqft,
        'Bed': property.bedroom,
        'Bath': property.washroom,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['predicted_price_in_taka'];
    } else {
      throw Exception('Failed to fetch predicted rent price');
    }
  }

@override
Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Section Header (Consistent with Crime Score)
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          'Predicted Rent',
          style: GoogleFonts.notoSans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),

      // Card
      Card(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Name & Floor
              Text(
                '${widget.property.buildingName} - Floor ${widget.property.floor.ceil()}',
                style: GoogleFonts.notoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),

              // Predicted Rent (FutureBuilder)
              FutureBuilder<double>(
                future: _predictedRentPrice,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.hasData) {
                    return _buildPredictedRent(snapshot.data!);
                  } else {
                    return const Text('No data available');
                  }
                },
              ),
              const SizedBox(height: 16),

              // Address Row
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.property.address,
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

// Predicted Rent Display (Consistent with Crime Score Layout)
Widget _buildPredictedRent(double rent) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 8),
      Text(
        '${rent.toStringAsFixed(2)} tk',
        style: GoogleFonts.notoSans(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    ],
  );
}
}
