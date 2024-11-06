import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final IconData iconImg;
  final Color iconColor;
  final Color? conBackColor; //nullable
  final Function() onbtnTap;
 
  const MenuWidget({
    Key? key, //nullable
    required this.iconImg, 
    required this.iconColor,
    this.conBackColor = Colors.white,
    required this.onbtnTap,
  }) : super(key: key);

  // MenuWidget({
  //   Key key,
  //   required this.iconImg,
  //   required this.iconColor,
  //   this.conBackColor,
  //   this.onbtnTap,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        onbtnTap();
      }, // Make sure onbtnTap is nullable
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: conBackColor,
          border: Border.all(color: Color.fromRGBO(69, 69, 69, 0.486)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(
          iconImg,
          color: iconColor,
        ),
      ),
    );
  }
}
