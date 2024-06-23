import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/otp_screen.dart';
import 'package:new_task/resetpass.dart';

import 'app_alerts.dart';
import 'colors.dart';
import 'cubits/state.dart';
import 'cubits/user_cubit.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, CommonState>(
      listener: (context, state) async {
        if (state is ForgetPassSuccess) {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => OtpScreen(

                        email: _emailController.text, isSignUp: false,
                      )),
             );
          // Navigator.push(
          //     context,
          //     PageTransition(
          //       type: PageTransitionType.rightToLeft,
          //       child: const ResetPassword(),
          //     ));
        } else if (state is ForgetPassError) {
          AppAlerts.customSnackBar(
              context: context, msg: 'User Not Found');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Forgot password"),
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
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 200, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Please enter your email address. You will receive a link to create a new password via email.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.orange),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
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
                            onTap: () async {
                              setState(() => isLoading = true);
                              await context
                                  .read<UserCubit>()
                                  .forgetPass(email: _emailController.text);
                              setState(() => isLoading = false);
                            },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Container(
                                    height: 55,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkblue,
                                    ),
                                    child: const Text(
                                      "Send",
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
