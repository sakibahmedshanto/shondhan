import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX for navigation and controller support
import 'package:shondhan/screens/auth-ui/sign_in_screen.dart';
import 'package:shondhan/screens/main_screen.dart'; // Import your MainScreen file here
import 'package:shondhan/controllers/auth_controller/sign_out_controller.dart'; // Import SignOutController

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.title});

  final String title;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final SignOutController _signOutController = Get.put(SignOutController());
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(119, 89, 203, 1),
            ),
            child: Text('SHONDHAN'),
          ),
          ListTile(
            title: const Text('Home'),
            selected: _selectedIndex == 0,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
          const Spacer(), // Pushes the Logout button to the bottom
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red), // Color to differentiate logout
            ),
            onTap: () async {
              // Sign out the user
              await _signOutController.signOut();
              Navigator.pushReplacement(context, 
              MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
} 