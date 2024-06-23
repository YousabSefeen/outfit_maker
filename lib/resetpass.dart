import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/app_alerts.dart';
import 'package:page_transition/page_transition.dart';

import 'colors.dart';
import 'cubits/state.dart';
import 'cubits/user_cubit.dart';
import 'homepage.dart';
import 'login.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isLoading = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return BlocListener<UserCubit, CommonState>(
      listener: (context, state) async {
        if (state is RestPasswordSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reset password"),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Image.asset("assets/Mask group.png",
                fit: BoxFit.fill,
                width: deviceSize.width,
                height: deviceSize.height),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'New Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if(_passwordController.text!=_confirmPasswordController.text){
                      AppAlerts.customSnackBar(context: context, msg: 'Password and Confirm Password does not matching');
                    }else{
                      setState(() => isLoading = true);
                      await context.read<UserCubit>().restPassword(
                        email: widget.email,
                        password:_passwordController.text ,
                        confirmPassword:_confirmPasswordController.text ,
                      );
                      setState(() => isLoading = false);
                    }

                  },
                  child: Container(
                    height: 55,
                    width: 300,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.darkblue,
                    ),
                    child:isLoading?const CircularProgressIndicator(color: Colors.white): const Text(
                      "Change Password ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'colors.dart';
import 'cubits/state.dart';
import 'cubits/user_cubit.dart';
import 'homepage.dart';
import 'login.dart';

class ResetPassword extends StatefulWidget {
  final String email;

  const ResetPassword({super.key, required this.email});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool isLoading = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return BlocListener<UserCubit, CommonState>(
      listener: (context, state) async {
        if (state is OTPSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Reset password"),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: deviceSize.height * 0.5,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 170),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your New Password",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.orange),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'New Password',
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Toggle visibility of the password
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
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
                                      child: const Home(),
                                      ));
                            },
                            child: Container(
                              height: 55,
                              width: 300,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: AppColors.darkblue,
                              ),
                              child: const Text(
                                "Change Password ",
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
      ),
    );
  }
}

 */
