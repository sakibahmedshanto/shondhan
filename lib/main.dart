import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shondhan/provider/theme_provider.dart'; // Correct path assumed
import 'package:shondhan/screens/auth-ui/splash_screen.dart';
import 'package:shondhan/screens/main_screen.dart';
import 'firebase_options.dart';
import 'utils/app-constant.dart';
import 'package:shondhan/screens/example_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider()..loadThemeMode(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstant.appMainName,
            theme: ThemeData(
              // Define light theme here, this might include specific colors, font styles, etc.
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple, // Primary swatch color
                brightness: Brightness.light,  // Ensuring brightness is set to light for light theme
              ),
              useMaterial3: true, // Optionally using Material Design 3 features
            ),
            darkTheme: ThemeData(
              // Define dark theme here, typically involves darker colors
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
            ),
            themeMode: themeProvider.themeMode, // Use theme mode managed by themeProvider
            home: const SplashScreen(),
            builder: EasyLoading.init(),
            getPages: [
              GetPage(name: '/', page: () => const SplashScreen()),
              GetPage(name: '/main', page: () => const MainScreen()),
               GetPage(name: '/example', page: () => ExampleScreen())
            ],
          );
        },
      ),
    );
  }
}
