import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/user-model.dart';
import 'package:shondhan/screens/owner/addProperty/add_new_property_screen.dart';
import 'package:shondhan/screens/owner/dashboard/dashboardwidgets/appbar_main.dart';
import 'package:shondhan/screens/owner/dashboard/dashboardwidgets/property_list_view.dart';

class DashboardMain extends StatelessWidget {
   DashboardMain({super.key,required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(50, 120, 91, 199),
      body: Column(
        children: [
          AppbarMain(um: userModel),
          ElevatedButton(
                onPressed: () {
                   Get.to(()=>AddPropertyScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  elevation: 5, // Adds shadow effect
                  shadowColor:
                      Colors.black.withOpacity(0.4), // Adjust shadow color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, color: Colors.white), // Optional icon
                    SizedBox(width: 5),
                    Text(
                      "Add your property",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
          Expanded(child: PropertyListWidget(userModel: userModel))
        ],
      ),
    );
  }
}