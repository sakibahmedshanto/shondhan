import 'package:flutter/material.dart';
import "../../../utils/app-constant.dart";
Widget buildDot(int index, int currentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? AppConstant.appScendoryColor : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }