import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/user-model.dart';
import 'package:shondhan/screens/owner/dashboard/dashboard_main.dart';

class SwitchToOwnerButton extends StatelessWidget {
  SwitchToOwnerButton({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(() => DashboardMain(userModel: userModel));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        elevation: 3, // Slightly reduced elevation for a less bold shadow
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // Smaller width
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded button
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ensures compact width
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business, // Icon representing ownership or business
            color: Colors.white,
            size: 20,
          ),
          SizedBox(width: 5),
          Text(
            "I'm an Owner",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
