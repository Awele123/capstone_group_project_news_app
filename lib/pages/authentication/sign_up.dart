import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/asset_images.dart';
import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:capstone_news_app/utils/auth_validators.dart';
import 'package:capstone_news_app/global_widgets/app_button.dart';
import 'package:capstone_news_app/global_widgets/app_textfield.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  bool passToggle = true;
  bool showConfirmPassword = true;
  bool isValidated = false;

  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() => setState(() {}));
    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
    confirmPasswordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  void validateFields() {
    final authCubit = context.read<AuthCubit>();
    final name = authCubit.namecontroller.text.trim();
    final email = authCubit.emailcontroller.text.trim();
    final password = authCubit.passwordcontroller.text.trim();
    final confirmPassword = authCubit.confirmPasswordController.text.trim();

    final nameValidation = AuthValidators.validateName(name);
    final emailValidation = AuthValidators.validateEmail(email);
    final passwordValidation = AuthValidators.validatePassword(password);
    final confirmPasswordValidation =
        AuthValidators.validateConfirmPassword(password, confirmPassword);

    setState(() {
      nameError = nameValidation;
      emailError = emailValidation;
      passwordError = passwordValidation;
      confirmPasswordError = confirmPasswordValidation;

      isValidated = nameError == null &&
          emailError == null &&
          passwordError == null &&
          confirmPasswordError == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          setState(() => isLoading = true);
        } else if (state is RegisteredState) {
          setState(() => isLoading = false);
          Navigator.pushNamed(context, RouteName.bottomNav);
        } else if (state is ErrorState) {
          setState(() => isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image.asset(AuthImages.logo,
                fit: BoxFit.contain, width: 50, height: 50),
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryColor2,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  onChanged: (_) => validateFields(),
                  controller: authCubit.namecontroller,
                  focusNode: nameFocus,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    filled: true,
                    fillColor: const Color(0xfff0fbff),
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff948b8b),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff62b7d5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (nameFocus.hasFocus && nameError != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(nameError!,
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (_) => validateFields(),
                  controller: authCubit.emailcontroller,
                  focusNode: emailFocus,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: const Color(0xfff0fbff),
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff948b8b),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff62b7d5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (emailFocus.hasFocus && emailError != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(emailError!,
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (_) => validateFields(),
                  controller: authCubit.passwordcontroller,
                  focusNode: passwordFocus,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => passToggle = !passToggle),
                      child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off,
                        size: 18,
                      ),
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: const Color(0xfff0fbff),
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff948b8b),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff62b7d5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (passwordFocus.hasFocus && passwordError != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(passwordError!,
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (_) => validateFields(),
                  controller: authCubit.confirmPasswordController,
                  focusNode: confirmPasswordFocus,
                  obscureText: showConfirmPassword,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () => setState(
                          () => showConfirmPassword = !showConfirmPassword),
                      child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off,
                        size: 18,
                      ),
                    ),
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: const Color(0xfff0fbff),
                    hintStyle: GoogleFonts.poppins(
                      color: const Color(0xff948b8b),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff62b7d5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                if (confirmPasswordFocus.hasFocus &&
                    confirmPasswordError != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(confirmPasswordError!,
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    ),
                  ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isValidated && !isLoading
                        ? () => authCubit.register()
                        : null,
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          )
                        : Text(
                            "Sign Up",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isValidated
                            ? AppColors.primaryColor2
                            : const Color.fromARGB(248, 230, 230, 230),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  "By clicking 'Sign up', you agree to receiving our newsletter and promotional advert.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 30.0),
                Row(
                  children: [
                    Expanded(
                        child:
                            Divider(thickness: 1.0, color: Colors.grey[300])),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('OR', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(
                        child:
                            Divider(thickness: 1.0, color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      // Handle Google login
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Color(0xFF5BBFD9),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Image.network(
                          'https://t4.ftcdn.net/jpg/03/91/79/25/360_F_391792593_BYfEk8FhvfNvXC5ERCw166qRFb8mYWya.jpg',
                          height: 25.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
