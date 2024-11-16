import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/models/user-model.dart';
import 'package:shondhan/utils/app-constant.dart';


class AppbarMain extends StatelessWidget {
   const AppbarMain({super.key,required this.um});
   final UserModel um;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width, // Ensure this container has a defined width
      decoration: const BoxDecoration(
        color: AppConstant.appScendoryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding( // Wrap with Padding to avoid infinite constraints
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 17.0),
        child: SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 10,),
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color.fromARGB(255, 247, 251, 251),
                foregroundImage: NetworkImage(um.userImg),
               
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    "Welcome, ${um.username}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Showcase & Sell with Confidence",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 246, 243, 243),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              // const Spacer(), // This will push the notification icon to the end
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Icons.notifications,
              //     size: 30,
              //     color: Color.fromARGB(255, 233, 223, 223),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}