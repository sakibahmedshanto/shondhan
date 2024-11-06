import 'package:flutter/material.dart';


class HousesWidget extends StatelessWidget{

  List<String> Locations=[
    "Uttara, Dhaka",
    "Upashahar, Rajshahi",
    "Board Bazar, Gazipur",
  ];

    List<String> HouseName=[
    "Summer House",
    "Emerald Palace",
    "Europe Palace",
  ];

   List<String> HouseImage=[
    "assets/images/home/house_2.png",
    "assets/images/home/house_5.png",
    "assets/images/home/house_3.png",
  ];

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for(var i=0;i<3;i++)
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(8),
              //height: 250,
              width: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10) 
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 140,
                        child: InkWell(
                          onTap:(){},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(HouseImage[i]),
                          ),
                        ),
                      )
                    ],
                  ),
                 Text(HouseName[i],
                 style: Theme.of(context).textTheme.titleLarge,
                 ) ,
                 Row( 
                  children: [
                    Icon(Icons.location_on_rounded),
                    Text(
                      Locations[i],
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                  ),
                  // Divider(thickness: 2),
                  // Text("5 Bed")
                ],
              ),
            )
        ],),
    );
  }
}