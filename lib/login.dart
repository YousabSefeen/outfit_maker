import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/app_alerts.dart';

import 'package:new_task/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';
import 'cubits/state.dart';
import 'cubits/user_cubit.dart';
import 'forgetpass.dart';
import 'homepage.dart'; // Add this import

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _key = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController pwController;
  late UserCubit cubit;

  @override
  void initState() {
    emailController = TextEditingController();
    pwController = TextEditingController();
    cubit = UserCubit();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  Future<void> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }

  bool isLoading = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);

    return BlocListener<UserCubit, CommonState>(
      listener: (context, state) {
        if (state is SuccessState) {
          AppAlerts.customSnackBar(context: context, isSuccess: true,msg: 'login successful ');

          _saveEmail(emailController.text); // Save email on successful login
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }if(state is FailedState){
          AppAlerts.customSnackBar(context: context, msg: 'Email or invalid password failed');
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: deviceSize.height * 0.4,
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back!",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.w600)),
                      SizedBox(height: 20),
                      Text(
                        "Sign in to continue",
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
                color: Colors.red,
                height: deviceSize.height * 0.6,
                width: double.infinity,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/Mask group.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: deviceSize.height * 0.6,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          // Added space between text and text fields
                          TextFormField(
                            cursorColor: Colors.amber,
                            validator: (text) {
                              if (text == '') {
                                return 'Field Required';
                              }
                              return null;
                            },
                            controller: emailController,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5),
                            // Text color
                            decoration: InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 211, 210, 210)),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.amber, width: 1.5),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          // Added space between text field and password field
                          TextFormField(
                            cursorColor: Colors.amber,
                            validator: (text) {
                              if (text == '') {
                                return 'Field Required';
                              }
                              return null;
                            },
                            obscureText: obscure,
                            controller: pwController,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.amber, width: 1.5),
                              ),
                              hintText: 'Password',
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 211, 210, 210)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() => obscure = !obscure);
                                  // Toggle visibility of the password
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: const ForgetPassword()));
                            },
                            child: const Text(
                              "Forget Password",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    setState(() => isLoading = true);
                                    await context.read<UserCubit>().signIn({
                                      'email': emailController.text,
                                      'password': pwController.text,
                                      'fcmToken': ''
                                    });
                                    setState(() => isLoading = false);
                                  },
                                  child: Container(
                                    height: 55,
                                    width: 300,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: AppColors.darkblue,
                                    ),
                                    child: isLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text(
                                            "SIGN IN",
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

                          const SizedBox(height: 20),
                          const SizedBox(height: 20),
                          // Added space between button and sign up text
                          GestureDetector(
                            onTap: () {
                              // Navigate to sign up page
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: SignUpPage()));
                              },
                              child: const Text(
                                ' Do you have any account? Sign up',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Colors.white, // Change color as desired
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

            ],
          ),
        ),
      ),
    );
  }
}
/*
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
              child: const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 230),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back!",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Sign in to continue",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.orange),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Image.asset("assets/Mask group.png",
                      fit: BoxFit.cover,width: double.infinity,
                       ),
                  SizedBox(
                    height: 500,

                    child: Column(
                      children: [
                        Text(
                          "Sign in to continuexxxxxx",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: AppColors.orange),
                        ),
                        Text(
                          "Sign in to continue",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: AppColors.orange),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
  */
