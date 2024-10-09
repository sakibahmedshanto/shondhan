import 'package:flutter/material.dart';
import 'package:shondhan/screens/Home/common/constants.dart';

class RentHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Image with rounded corners
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: Image.asset(
                    Constants.rentList[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Button for "For Rent" page
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForRentPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Deep Purple background color
                  ),
                  child: Text(
                    "For Rent",
                    style: TextStyle(color: Colors.white), // White text color
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing between the buttons
            // Second Image with rounded corners
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: Image.asset(
                    Constants.rentList[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Button for "To Rent" page
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ToRentPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Deep Purple background color
                  ),
                  child: Text(
                    "To Rent",
                    style: TextStyle(color: Colors.white), // White text color
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add some spacing at the bottom
          ],
        ),
      ),
    );
  }
}

class ForRentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('For Rent'),
      ),
      body: Center(
        child: Text('For Rent Page'),
      ),
    );
  }
}

class ToRentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Rent'),
      ),
      body: Center(
        child: Text('To Rent Page'),
      ),
    );
  }
}
