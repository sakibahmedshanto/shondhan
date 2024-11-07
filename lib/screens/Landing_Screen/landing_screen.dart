import 'package:flutter/material.dart';
import 'package:shondhan/models/user-model.dart';
import 'package:shondhan/screens/Landing_Screen/houses_widget.dart';
import 'package:shondhan/screens/Landing_Screen/switch_to_owner_button.dart';
import 'current_location.dart';
import 'map_ar_button.dart';
import 'plot_category.dart';

class LandingScreen extends StatelessWidget {
 
  LandingScreen({super.key,required this.userModel});
  final UserModel userModel;
  final List<String> PropertyType = [
    "Home",
    "Office",
    "Fatory",
    "Plot",
  ];

  final List<Icon> PropertyIcons = [
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
              const CurrentLocation(
                locationName: "Gazipur,",
                city: "Dhaka",
              ),
              SwitchToOwnerButton(userModel: userModel),

              /// two buttons
              const MapArButtons(),
              // Categories 4 buttons
              Flexible(
                child: PlotCategory(
                  PropertyIcons: PropertyIcons,
                  PropertyType: PropertyType,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Text(
                      "Nearby By You...",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextButton(onPressed:() {},
                      child: const Text("See all"),
                    )
                ],
              ),
              const SizedBox(height: 10),            
              HousesWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
