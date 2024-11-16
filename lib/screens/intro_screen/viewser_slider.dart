import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shondhan/screens/auth-ui/welcome_screen.dart';
import 'package:shondhan/utils/app-constant.dart';

import 'build_dot.dart';

class ViewserSlider extends StatelessWidget {
  ViewserSlider({super.key});

  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> splashData = [
      {
        "image": "assets/intro_images/1.png",
        "text":
            "Effortlessly list and manage your property as a host",
        "Title": "Welcome To Shondhan",
        "height": "170",
      },
      {
        "image": "assets/intro_images/2.png",
        "text": "Discover and rent your perfect space as a tenant",
        "Title": "Explore Your Options",
        "height": "170",
      },
      {
        "image": "assets/intro_images/3.png",
        "text": "Make renting and hosting more effortless and rewarding.",
        "Title": "Craft your personalized journey",
        "height": "170",
      }
    ];

    return Scaffold(
      backgroundColor: AppConstant.appBackgroundColor ,
      body: Column(
        
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: splashData.length,
              onPageChanged: (int page) {
                _currentPage.value = page;
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: Image.asset(
                        splashData[index]["image"]!,
                        height: double.parse(splashData[index]["height"]!),
                      ),
                    ),
                    const SizedBox(height: 55),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        splashData[index]["Title"]!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        splashData[index]["text"]!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  splashData.length,
                  (index) => buildDot(index, _currentPage.value),
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(
                        () => const WelcomeScreen()); // Navigate to the main page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appScendoryColor, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding:const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: const Text("Skip"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage.value == splashData.length - 1) {
                      Get.offAll(
                          () => const WelcomeScreen()); // Navigate to the main page
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:AppConstant.appScendoryColor, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding:const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Padding
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  child: Obx(() => Text(
                      _currentPage.value == splashData.length - 1
                          ? "Get Started"
                          : "Next")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
