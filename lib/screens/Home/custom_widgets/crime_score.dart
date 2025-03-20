import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title outside the card (consistent with other sections)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Crime Score',
            style: GoogleFonts.notoSans(
              fontSize: 20, // Matches Section Header
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple, // Matches Section Header
            ),
          ),
        ),

        // Crime Score Card
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<double>(
              future: _crimeScore,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                } else if (snapshot.hasData) {
                  double score = snapshot.data!;
                  String comment;
                  Color commentColor;
                  IconData icon;
                  Color barColor;

                  // Determine comment, colors, and icon based on the score
                  if (score <= 3) {
                    comment = 'Safe';
                    commentColor = Colors.green;
                    barColor = Colors.green.shade600;
                    icon = Icons.verified_user;
                  } else if (score > 3 && score <= 6) {
                    comment = 'You should be careful';
                    commentColor = Colors.orange;
                    barColor = Colors.orange.shade600;
                    icon = Icons.warning_amber_rounded;
                  } else if (score > 6 && score <= 8) {
                    comment = 'Be very cautious';
                    commentColor = Colors.deepOrange;
                    barColor = Colors.deepOrange.shade600;
                    icon = Icons.report_problem;
                  } else {
                    comment = 'Very dangerous';
                    commentColor = Colors.red;
                    barColor = Colors.red.shade600;
                    icon = Icons.dangerous;
                  }

                  return Column(
                    children: [
                      // Safety Status (Centered Below "Crime Score")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: commentColor, size: 26),
                          const SizedBox(width: 8),
                          Text(
                            comment,
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: commentColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Progress Bar
                      Container(
                        height: 22,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade300,
                        ),
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: 22,
                              width: MediaQuery.of(context).size.width *
                                  0.7 *
                                  (score / 10.0), // Adjusts to screen width
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: barColor, // Solid color (No gradient)
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Score Display (Bottom)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Crime Score:',
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            '${score.toStringAsFixed(1)} / 10',
                            style: GoogleFonts.notoSans(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}