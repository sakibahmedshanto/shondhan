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
        "image": "assets/intro_images/welcome.png",
        "text":
            "We make learning engaging & effective, so that you are ready to achieve your goals.",
        "Title": "Welcome To Shongkolpo",
        "height": "150",
      },
      {
        "image": "assets/intro_images/2.png",
        "text": "Easy and fast learning anytime to you",
        "Title": "Quick And Easy Learning",
        "height": "200",
      },
      {
        "image": "assets/intro_images/3.png",
        "text": "Easy and fast learning anytime to you",
        "Title": "Quick And Easy Learning",
        "height": "200",
      }
    ];

    return Scaffold(
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
                    Image.asset(
                      splashData[index]["image"]!,
                      height: double.parse(splashData[index]["height"]!),
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
                        () => WelcomeScreen()); // Navigate to the main page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appScendoryColor, // Background color
                    foregroundColor: Colors.white, // Text color
                    padding:const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12), // Padding
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
                          () => WelcomeScreen()); // Navigate to the main page
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
                        horizontal: 25, vertical: 12), // Padding
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
