import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:flutter/material.dart';
import 'package:new_task/signup.dart';
import 'package:page_transition/page_transition.dart';

import '../apis/dio_helper.dart';
import '../models/PredSize.dart';
import '../repos/apis_repo.dart'; // Import the ApiRepository class
import 'colors.dart';
import 'models/error_model.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextEditingController _weight = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final int _gender = 0;
  int _currentPageIndex = 0;
  int _selectedGenderIndex = 0;
  late PageController _pageController;
  double _bellyShapeValue = 0.5;
  final List<String> _bellyShapeLabels = [
    'Very Tight',
    'Regular',
    'Very Loose',
  ];
  String _predictedSize = "";

  late ApiRepository _apiRepository; // Declare ApiRepository instance

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _apiRepository =
        ApiRepository(ApiService()); // Initialize ApiRepository instance
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void predict() async {
    // Determine gender based on selected index
    int genderValue = _selectedGenderIndex == 0 ? 1 : 0;

    // Prepare input data map for API request
    final Map<String, dynamic> map = {
      "input_data": [_weight.text, _age.text, _height.text, genderValue]
    };

    try {
      // Call API to predict size
      final Either<ApiError, PredSize> result = (await _apiRepository
          .predictOrder(map)) as Either<ApiError, PredSize>;

      // Handle result based on either Left (error) or Right (success)
      result.fold(
        (left) {
          print("left");
          // Handle error case
          print('API Error: ${left.message}');
          // Optionally, show an error message to the user
        },
        (predsize) {
          // Handle success case
          setState(() {
            _predictedSize = predsize
                .class_name; // Access correct property from Order object
          });
        },
      );
    } catch (e) {
      // Handle other exceptions (e.g., network errors)
      print('Error: $e');
      // Optionally, show an error message to the user
    }
  }

  void _nextPage() async {
    if (_currentPageIndex < 2) {
      if (_currentPageIndex == 1) {
        // Call predict() when navigating from Page 1 to Page 2 (assuming Page 2 is the prediction page)
        predict();
      }
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Handle completion actions if needed
    }
  }

  void _selectGender(int index) {
    setState(() {
      _selectedGenderIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                  children: [
                    // Page 1
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  "Please provide the following details",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _age,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Age',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _height,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Height',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: _weight,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Weight',
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Gender",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _selectGender(0);
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: _selectedGenderIndex == 0
                                              ? AppColors.darkblue
                                              : AppColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Male',
                                            style: TextStyle(
                                              color: _selectedGenderIndex == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        _selectGender(1);
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: _selectedGenderIndex == 1
                                              ? AppColors.darkblue
                                              : AppColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Female',
                                            style: TextStyle(
                                              color: _selectedGenderIndex == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Page 2
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: SafeArea(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const Text(
                                  "Belly Shape",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _bellyShapeValue = 0;
                                          _selectedGenderIndex = 0;
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: _selectedGenderIndex == 0
                                              ? AppColors.darkblue
                                              : AppColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Slimmer',
                                            style: TextStyle(
                                              color: _selectedGenderIndex == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _bellyShapeValue = 0.5;
                                          _selectedGenderIndex = 1;
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: _selectedGenderIndex == 1
                                              ? AppColors.darkblue
                                              : AppColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Regular',
                                            style: TextStyle(
                                              color: _selectedGenderIndex == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _bellyShapeValue = 1;
                                          _selectedGenderIndex = 2;
                                        });
                                      },
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: _selectedGenderIndex == 2
                                              ? AppColors.darkblue
                                              : AppColors.white,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Curvies',
                                            style: TextStyle(
                                              color: _selectedGenderIndex == 2
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                    "assets/body2.png",
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // Inside Page 2 of your PageView
                                Container(
                                  alignment: Alignment.center,
                                  height: 180,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.white,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Recommended Size",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          _predictedSize,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Page 3
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Visibility(
                  visible: _currentPageIndex > 0,
                  // Show only if not on the first page
                  child: GestureDetector(
                    onTap: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.darkblue),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: AppColors.darkblue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: GestureDetector(
                  onTap: _currentPageIndex < 1
                      ? _nextPage
                      : () async {
                          _nextPage();
                        },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.darkblue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        _currentPageIndex == 1 ? 'Ai Size' : 'Continue',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Visibility(
                  visible: _currentPageIndex > 0,
                  // Show only if not on the first page
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SignUpPage()));
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.darkblue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          "Start Now",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 2; i++)
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.darkblue,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Order APIs
}
