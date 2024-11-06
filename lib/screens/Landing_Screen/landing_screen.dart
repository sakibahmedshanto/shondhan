import 'package:flutter/material.dart';
import 'current_location.dart';
import 'map_ar_button.dart';
import 'plot_category.dart';

class LandingScreen extends StatelessWidget {
  List<String> PropertyType = [
    "Home",
    "Office",
    "Fatory",
    "Plot",
  ];

  List<Icon> PropertyIcons = [
    Icon(Icons.house_rounded, size: 40, color: Colors.deepPurple.shade400),
    Icon(Icons.apartment, size: 40, color: Colors.deepPurple.shade400),
    Icon(Icons.factory_outlined, size: 40, color: Colors.deepPurple.shade400),
    Icon(Icons.landscape_sharp, size: 40, color: Colors.deepPurple.shade400),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F6FB),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentLocation(
                locationName: "Gazipur,",
                city: "Dhaka",
              ),

              /// two buttons
              MapArButtons(),
              // Categories 4 buttons
              Flexible(
                child: PlotCategory(
                  PropertyIcons: PropertyIcons,
                  PropertyType: PropertyType,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                      "Nearby By You...",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(onPressed:() {},
                      child: Text("See all"),
                    )
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}