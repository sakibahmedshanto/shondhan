import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/custom_position_model.dart';

class CrimeScoreWidget extends StatefulWidget {
  final CustomPosition position;

  const CrimeScoreWidget({Key? key, required this.position}) : super(key: key);

  @override
  _CrimeScoreWidgetState createState() => _CrimeScoreWidgetState();
}

class _CrimeScoreWidgetState extends State<CrimeScoreWidget> {
  late Future<double> _crimeScore;

  @override
  void initState() {
    super.initState();
    _crimeScore = fetchCrimeScore(widget.position);
  }

  Future<double> fetchCrimeScore(CustomPosition position) async {
    final response = await http.post(
      Uri.parse('https://crimeprediction-pk3f.onrender.com/predict'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'longitude': position.longitude,
        'latitude': position.latitude,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['crime_score'];
    } else {
      throw Exception('Failed to load crime score');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Crime Score',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<double>(
              future: _crimeScore,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  );
                } else if (snapshot.hasData) {
                  double score = snapshot.data!;
                  String comment;
                  Color commentColor;

                  // Determine comment and color based on the score
                  if (score <= 3) {
                    comment = 'Safe';
                    commentColor = Colors.green;
                  } else if (score > 3 && score <= 6) {
                    comment = 'You should be careful';
                    commentColor = Colors.orange;
                  } else if (score > 6 && score <= 8) {
                    comment = 'Be very cautious';
                    commentColor = Colors.deepOrange;
                  } else {
                    comment = 'Very dangerous';
                    commentColor = Colors.red;
                  }

                  return Column(
                    children: [
                      Container(
                        height: 20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: score / 10.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.lerp(Colors.green, Colors.red, score / 10.0),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Crime Score: ${score.toStringAsFixed(1)} out of 10',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        comment,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: commentColor,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('No data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
