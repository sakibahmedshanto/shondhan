import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/user-model.dart';
import 'package:shondhan/screens/owner/addProperty/add_new_property_screen.dart';
import 'package:shondhan/screens/owner/dashboard/dashboardwidgets/appbar_main.dart';
import 'package:shondhan/screens/owner/dashboard/dashboardwidgets/property_list_view.dart';

class DashboardMain extends StatelessWidget {
  const DashboardMain({super.key, required this.userModel});
  final UserModel userModel;
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color.fromARGB(50, 120, 91, 199),
    body: Column(
      children: [
        /// Top Section - AppBar + Button Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(60, 104, 58, 183),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              AppbarMain(um: userModel),
              const SizedBox(height: 12),

              /// Eye-Catching Button with Soft Animation
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => AddPropertyScreen(uId: userModel.uId));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 6,
                    backgroundColor: Colors.deepPurple,
                    shadowColor: Colors.black.withOpacity(0.4),
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(
                      Colors.deepPurpleAccent.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_location_alt_rounded,
                      color: Colors.white, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        "Add Your Property",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Spacing before Property List
        const SizedBox(height: 10),

        /// Property List Section
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: PropertyListWidget(userModel: userModel),
            ),
          ),
        ),
      ],
    ),
  );
}
}
