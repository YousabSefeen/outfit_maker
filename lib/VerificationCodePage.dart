
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'colors.dart';
import 'login.dart';
import 'resetpass.dart'; // Assuming this is where the ResetPassword widget is defined

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({Key? key}) : super(key: key);

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  late TextEditingController codeController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Code"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 150, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please enter the verification code sent to your email.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: AppColors.orange,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        hintText: 'Verification Code',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                          height:
                              20), // Added space between text and text fields
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: const LoginPage(),
                              ),
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
                              "Verify",
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
    );
  }
}
