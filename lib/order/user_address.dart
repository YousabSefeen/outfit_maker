
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../navigationBar.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _key = GlobalKey<FormState>();
  late TextEditingController mobileController;
  late TextEditingController stateController;
  late TextEditingController cityController;
  late TextEditingController streetController;
  String email = '';

  @override
  void initState() {
    mobileController = TextEditingController();
    stateController = TextEditingController();
    cityController = TextEditingController();
    streetController = TextEditingController();
    super.initState();
    _loadAddress();
    _loadEmail();
  }

  @override
  void dispose() {
    mobileController.dispose();
    stateController.dispose();
    cityController.dispose();
    streetController.dispose();
    super.dispose();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('user_email') ?? '';
    });
  }

  // Load address data from local storage
  Future<void> _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileController.text = prefs.getString('mobile') ?? '';
      stateController.text = prefs.getString('state') ?? '';
      cityController.text = prefs.getString('city') ?? '';
      streetController.text = prefs.getString('street') ?? '';
    });
  }

  // Save address data to local storage
  Future<void> _saveAddress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', mobileController.text);
    await prefs.setString('state', stateController.text);
    await prefs.setString('city', cityController.text);
    await prefs.setString('street', streetController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Set Your Address",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Fill in the details below",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.orange),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        email, // Display the email here
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkblue,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (text) {
                          if (text == '') {
                            return 'Field Required';
                          }
                          return null;
                        },
                        controller: mobileController,
                        decoration: const InputDecoration(
                          hintText: 'Mobile',
                          hintStyle: TextStyle(color: AppColors.darkblue),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkblue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (text) {
                          if (text == '') {
                            return 'Field Required';
                          }
                          return null;
                        },
                        controller: stateController,
                        decoration: const InputDecoration(
                          hintText: 'State',
                          hintStyle: TextStyle(color: AppColors.darkblue),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkblue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (text) {
                          if (text == '') {
                            return 'Field Required';
                          }
                          return null;
                        },
                        controller: cityController,
                        decoration: const InputDecoration(
                          hintText: 'City',
                          hintStyle: TextStyle(color: AppColors.darkblue),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkblue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (text) {
                          if (text == '') {
                            return 'Field Required';
                          }
                          return null;
                        },
                        controller: streetController,
                        decoration: const InputDecoration(
                          hintText: 'Street',
                          hintStyle: TextStyle(color: AppColors.darkblue),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.darkblue),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () async {
                          if (_key.currentState!.validate()) {
                            await _saveAddress();
                            Fluttertoast.showToast(
                                msg: 'Address saved successfully!');
                            // Add logic to navigate to another page if needed
                          } else {
                            Fluttertoast.showToast(msg: 'Fields Required!');
                          }
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.darkblue,
                          ),
                          child: const Text(
                            "SAVE ADDRESS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
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
    );
  }
}
