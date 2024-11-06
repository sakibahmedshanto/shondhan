import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/augmented/view_annotations.dart';

class FloatingWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String txt;
  FloatingWidget({
    required this.leadingIcon,
    required this.txt,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      child: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        elevation: 5,
        onPressed: () {
          Get.to(()=>ViewAnnotations());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(75.0),
        ),
        heroTag: null,
        child: Ink(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0),
            borderRadius: BorderRadius.circular(75.0),
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 300.0,
              minHeight: 50.0,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  leadingIcon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 80,
                  child: Text(
                    txt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
