import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_task/otp_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'app_alerts.dart';
import 'colors.dart';
import 'cubits/state.dart';
import 'cubits/user_cubit.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    return BlocListener<UserCubit, CommonState>(
      listener: (context, state) async {
        if (state is SignUpSuccess) {

          AppAlerts.customSnackBar(context: context, isSuccess: true,msg: 'Successfully registered');

          Navigator.of(context).push(

            MaterialPageRoute(

                builder: (context) {

                  return OtpScreen(
                      email: _emailController.text, isSignUp: true,

                    );
                },),
          );

        } else if (state is SignUpError) {
        AppAlerts.customSnackBar(context: context, msg: 'User already exists');
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: deviceSize.height * 0.28,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 20.0, bottom: 40),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sign Up",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w600)),
                    SizedBox(height: 20),
                    Text(
                      "Create your account",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.orange),
                    ),
                  ],
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
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _usernameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'User Name',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _phoneController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Email Address',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }

                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: BlocConsumer<UserCubit, CommonState>(
                                listener: (context, state) {

                                },
                                builder: (context, state) {
                                  return ElevatedButton(
                                    onPressed: () async {

                                      setState(() => isLoading = true);
                                      await context.read<UserCubit>().signUp(
                                          name: _usernameController.text.trim(),
                                          phoneNumber: _phoneController.text.trim(),
                                          email:_emailController.text.trim(),
                                          password: _passwordController.text.trim(),
                                          confirmPassword: _confirmPasswordController.text.trim(),
                                      );
                                      if(context.mounted){
                                        await context
                                            .read<UserCubit>()
                                            .forgetPass(email: _emailController.text);
                                      }

                                      setState(() => isLoading = false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.darkblue,
                                      minimumSize: const Size(300, 55),
                                    ),
                                    child:isLoading?const CircularProgressIndicator(color: Colors.white,): const Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const LoginPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Already have an account? Sign in.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
