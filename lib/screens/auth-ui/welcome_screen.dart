import 'sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../controllers/auth_controller/google_sign_in_controller.dart';
import '../../../utils/app-constant.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleSignInController _googleSignInController = Get.put(GoogleSignInController());

  @override
  void initState() {
    super.initState();
    requestNotificationPermissions();
  }

  void requestNotificationPermissions() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
        title:const Text(
          "",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
      ),
      body: Column(
        children: [
          // Lottie animation
          Center(
            child: Container(
                width: Get.width / 1,
                height: Get.height / 2.25,
                decoration:const BoxDecoration(
                  color: AppConstant.appMainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.topCenter,
                child: Image.asset('assets/images/logo.png')
                //Lottie.asset('assets/images/splash-icon.json')
                ),
          ),
          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const  SizedBox(height: 20),
                const  Text(
                    " quotes here",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 const SizedBox(height: 20),
                  Container(
                    width: Get.width / 1.2,
                    height: Get.height / 12,
                    decoration: BoxDecoration(
                      color: AppConstant.appScendoryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton.icon(
                      icon: Image.asset(
                        'assets/images/final-google-logo.png',
                        width: Get.width / 12,
                        height: Get.height / 12,
                      ),
                      label:const Text(
                        "Sign in with Google",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () {
                        _googleSignInController.signInWithGoogle();
                      },
                    ),
                  ),
                const  SizedBox(height: 20),
                  Container(
                    width: Get.width / 1.2,
                    height: Get.height / 12,
                    decoration: BoxDecoration(
                      color: AppConstant.appScendoryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton.icon(
                      icon:const Icon(
                        Icons.email,
                        color: AppConstant.appTextColor,
                      ),
                      label:const Text(
                        "Sign in with Email",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () {
                        Get.to(() =>const SignInScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
