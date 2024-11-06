import 'package:flutter/material.dart';

class PlotCategory extends StatelessWidget {
  final List<Icon> PropertyIcons;  // Pass icons to the widget
  final List<String> PropertyType;  // Pass property types to the widget

  PlotCategory({
    required this.PropertyIcons,
    required this.PropertyType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          "Categories",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 10),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: PropertyIcons.length, // Dynamic item count
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Define separate actions based on index
                  switch (index) {
                    case 0:
                      print("First button pressed");
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
                  margin: EdgeInsets.all(7),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PropertyIcons[index],
                      SizedBox(height: 5),
                      Text(
                        PropertyType[index],
                        style: TextStyle(
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
