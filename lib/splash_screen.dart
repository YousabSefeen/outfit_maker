
import 'package:flutter/material.dart';
import 'package:new_task/quiz.dart';
import 'package:page_transition/page_transition.dart';

import 'colors.dart';
import 'core/cache_manager.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    CacheHelper.saveToShared(key: 'isFirstTime', value: 'any');
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {});
            },
            children: [
              Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/outfit maker logo.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Mask group.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "to Outfit maker!.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Elevating your",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "t-shirt experience",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkblue,
                                    ),
                                    child: const Text(
                                      "Get Started",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/outfit maker logo.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Mask group.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Step 1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Choose Your Style",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Explore and select your ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "preferred t-shirt style",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      2,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkblue,
                                    ),
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/outfit maker logo.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Mask group.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Step 2",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Pick Your Color",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Stylish colors to match your ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "personal taste",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _pageController.animateToPage(
                                      3,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkblue,
                                    ),
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 350,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/outfit maker logo.png"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Mask group.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Step 3",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "Design Your T-Shirt",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Where you can let your ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                "creativity shine",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 120,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child:
                                                CacheHelper.getToken() != null
                                                    ? const Home()
                                                    : QuizPage()));
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkblue,
                                    ),
                                    child: const Text(
                                      "Get Started",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 0,
            child: TextButton(
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: CacheHelper.getToken() != null
                            ? const Home()
                            : QuizPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final Color backgroundColor;
  final String title;

  const SplashPage({
    super.key,
    required this.backgroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
