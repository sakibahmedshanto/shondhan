import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/Home/home_page_screen.dart';

class PlotCategory extends StatelessWidget {
  final List<Icon> PropertyIcons;  // Pass icons to the widget
  final List<String> PropertyType;  // Pass property types to the widget

  const PlotCategory({super.key, 
    required this.PropertyIcons,
    required this.PropertyType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          "Categories",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: PropertyIcons.length, // Dynamic item count
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: .95,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Define separate actions based on index
                  switch (index) {
                    case 0:
                      Get.to(()=>HomePageScreen());
                      break;
                    case 1:
                      print("Second button pressed");
                      break;
                    case 2:
                      print("Third button pressed");
                      break;
                    case 3:
                      print("Fourth button pressed");
                      break;
                    default:
                      print("Unknown button pressed");
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(7),
                
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PropertyIcons[index],
                      const SizedBox(height: 5),
                      Text(
                        PropertyType[index],
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
