import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HouseWidget extends StatelessWidget {
  final IconData icon;
  final String number;
  final String type;

  const HouseWidget({
    super.key,
    required this.icon,
    required this.number,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.white,
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    number,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              type,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
