import 'package:flutter/material.dart';
import 'package:shondhan/models/user-model.dart';
import 'package:shondhan/screens/Landing_Screen/switch_to_owner_button.dart';
import 'houses_widget.dart';
import 'map_ar_button.dart';
import 'plot_category.dart';
import 'package:shondhan/screens/settings/settings_page.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key, required this.userModel});
  final UserModel userModel;
  final List<String> propertyType = [
    "Home",
    "Office",
    "Furniture",
    "Plot",
  ];

  List<Icon> getPropertyIcons(ThemeData theme) => [
    Icon(Icons.house_rounded, size: 40, color: theme.colorScheme.primary),
    Icon(Icons.apartment, size: 40, color: theme.colorScheme.primary),
    Icon(Icons.factory_outlined, size: 40, color: theme.colorScheme.primary),
    Icon(Icons.landscape_sharp, size: 40, color: theme.colorScheme.primary),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context); // Correctly fetch theme data

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.background, // Corrected to use colorScheme
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: theme.colorScheme.primary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
          ],
        ),
        backgroundColor: theme.colorScheme.background, // Corrected to use colorScheme
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchToOwnerButton(userModel: userModel),
              const MapArButtons(),
              Flexible(
                child: PlotCategory(
                  PropertyIcons: getPropertyIcons(theme),
                  PropertyType: propertyType,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nearby By You...",
                    style: theme.textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
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
