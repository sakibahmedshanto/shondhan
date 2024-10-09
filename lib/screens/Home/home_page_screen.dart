import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shondhan/screens/Home/common/constants.dart';
import 'package:shondhan/screens/Home/custom_widgets/filter_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/floating_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/image_widget.dart';
import 'package:shondhan/screens/Home/custom_widgets/menu_widget.dart';

class HomePageScreen extends StatelessWidget {
  final filterArray = [
    "<\$220.000",
    "For sale",
    "3-4 beds",
    "Kitchen",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(255, 255, 255, 20),
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 20),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingWidget(
        leadingIcon: Icons.explore,
        txt: "Map view", // Removed key: key
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MenuWidget(
                    iconImg: Icons.subject,
                    iconColor: Color.fromRGBO(0, 0, 0, 0.486),
                    onbtnTap: () {},
                  ),
                  MenuWidget(
                    iconImg: Icons.repeat,
                    iconColor: Color.fromRGBO(0, 0, 0, 0.486),
                    onbtnTap: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "City",
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: Color.fromRGBO(69, 69, 69, 0.486),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "San Francisco",
                style: GoogleFonts.notoSans(
                  fontSize: 36,
                  color: Color.fromRGBO(0, 0, 0, 0.486),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Divider(
                color: Color.fromRGBO(69, 69, 69, 0.486),
                thickness: .2,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal, 
                  itemCount: filterArray.length,
                  itemBuilder: (context, index) {
                    return FilterWidget(
                      filterTxt: filterArray[index], // Removed unnecessary key
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: List.generate(
                  Constants.houseList.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ImageWidget(
                        Constants.houseList[index],
                        index,
                        Constants.imageList,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
