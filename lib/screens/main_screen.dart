import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/tem_property_view/add_new_property_screen.dart';
import 'package:shondhan/screens/tem_property_view/property_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Text("MainScreen"),),
    
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: ()=>{ Get.to(AddPropertyScreen()) }, child: Text("Add property")),
        ElevatedButton(onPressed: ()=>{ Get.to(()=>PropertiesScreen()) }, child: Text("view property")),

      ],
    ),
    );
  }
}