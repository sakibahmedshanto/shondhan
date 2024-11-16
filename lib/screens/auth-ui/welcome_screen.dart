import 'sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../controllers/auth_controller/google_sign_in_controller.dart';
import '../../../utils/app-constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

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
      backgroundColor: AppConstant.appBackgroundColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor:AppConstant.appBackgroundColor,
      //   title:const Text(
      //     "",
      //     style: TextStyle(color: AppConstant.appTextColor),
      //   ),
      // ),
      body: Container(
        child: Column(
          children: [
            // Lottie animation
            const SizedBox(
              height: 80,
            ),
            Center(
              child: Image.asset('assets/images/logo.png',height: Get.height/2.3,),
            ),
            // Content
           const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
              "Find your home in Augmented Reality",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(78, 8, 132, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 90),
                    Container(
                      width: Get.width / 1.2,
                      height: Get.height / 14,
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
                        label: const Text(
                          "Sign in with Google",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        onPressed: () {
                          _googleSignInController.signInWithGoogle();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: Get.width / 1.2,
                      height: Get.height / 14,
                      decoration: BoxDecoration(
                        color: AppConstant.appScendoryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.email,
                          color: AppConstant.appTextColor,
                        ),
                        label: const Text(
                          "Sign in with Email",
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                        onPressed: () {
                          Get.to(() => const SignInScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
