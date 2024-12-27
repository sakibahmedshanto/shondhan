import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.property.buildingName} - Floor ${widget.property.floor.ceil()}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder<double>(
              future: _predictedRentPrice,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else if (snapshot.hasData) {
                  return Text(
                    'Predicted Rent: ${snapshot.data!.toStringAsFixed(2)} tk',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  );
                } else {
                  return Text('No data available');
                }
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.deepPurple),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    widget.property.address,
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
