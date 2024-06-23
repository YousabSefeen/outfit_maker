import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/app_alerts.dart';
import 'package:new_task/colors.dart';
import 'package:new_task/login.dart';
import 'package:new_task/resetpass.dart';

import 'cubits/state.dart';
import 'cubits/user_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final bool isSignUp;

  const OtpScreen({super.key, required this.email,required this.isSignUp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _numberOneController = TextEditingController();
  final TextEditingController _numberTwoController = TextEditingController();
  final TextEditingController _numberThereController = TextEditingController();
  final TextEditingController _numberFourController = TextEditingController();
  String otpFinally = '';
  bool isLoading = false;
  bool isResendAgain = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, CommonState>(
      listener: (context, state) async {
        if (state is OTPSuccess) {
          if(widget.isSignUp==true){
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const LoginPage()),
            );
          }
          else{
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ResetPassword(
                    email: widget.email,
                  )),
            );

          }
        } else if (state is OTPError) {
          AppAlerts.customSnackBar(
              context: context, msg: 'Invalid Otp provided');
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verification Code',
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text:
                          'We have sent the verification code to your email address: ',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: widget.email,
                      style: const TextStyle(
                          fontSize: 17,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _customField(controller: _numberOneController),
                    _customField(controller: _numberTwoController),
                    _customField(controller: _numberThereController),
                    _customField(controller: _numberFourController),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 15)),
                        backgroundColor: MaterialStatePropertyAll(AppColors.darkblue),
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        overlayColor: MaterialStatePropertyAll(Colors.grey),
                      ),
                      onPressed: () async {
                        otpFinally = _numberOneController.text +
                            _numberTwoController.text +
                            _numberThereController.text +
                            _numberFourController.text;
                        if (otpFinally.length < 4) {
                          AppAlerts.customSnackBar(
                              context: context, msg: 'Invalid OTP provided');
                        }

                        setState(() => isLoading = true);
                        await context.read<UserCubit>().confirmOtp(
                            email: widget.email, verifyCode: otpFinally);
                        setState(() => isLoading = false);
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Confirm',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            )),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Didn\'t receive the verification OTP? ',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () async {
                        setState(() => isResendAgain = true);
                        await context
                            .read<UserCubit>()
                            .forgetPass(email: widget.email);
                        setState(() => isResendAgain = false);
                      },
                      child: isResendAgain
                          ? DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.green
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText('Resending...'),
                                ],
                                isRepeatingAnimation: true,
                              ),
                            )
                          : const Text(
                              'Resend again',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.darkblue,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _customField({
    required TextEditingController controller,
    bool? isFourField=false,
  }) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: TextField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.allow(RegExp(r'\d')),
            // تقييد الإدخال ليكون رقمًا فقط
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blue.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
          ),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
