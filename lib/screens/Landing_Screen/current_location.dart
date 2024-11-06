import 'package:flutter/material.dart';

class CurrentLocation extends StatelessWidget {
  final String locationName;
  final String city;

  const CurrentLocation({
    Key? key,
    required this.locationName,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      locationName,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      city,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.black54,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
