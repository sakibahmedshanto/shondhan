import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/Landing_Screen/landing_screen.dart';
import 'package:shondhan/screens/Landing_Screen/locations.dart';
import 'package:shondhan/screens/auth-ui/splash_screen.dart';
import 'package:shondhan/screens/main_screen.dart'; // Import MainScreen
import 'firebase_options.dart';
import 'utils/app-constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appMainName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const SplashScreen(), 
      home: LandingScreen(),
      builder: EasyLoading.init(),
      // navbar
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/main', page: () => MainScreen()), // Add route for MainScreen
      ],
    );
  }
}
