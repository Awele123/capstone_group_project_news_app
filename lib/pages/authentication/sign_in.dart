import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/global_widgets/app_textfield.dart';
import 'package:capstone_news_app/global_widgets/app_button.dart';
import 'package:capstone_news_app/constants/asset_images.dart';
import 'package:capstone_news_app/route/routename.dart';

import 'package:capstone_news_app/utils/auth_validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool showpassword = true;
  String? emailError;
  String? passwordError;
  bool isValidated = false;

  @override
  void initState() {
    super.initState();
    emailFocus.addListener(() => setState(() {}));
    passwordFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void validateFields() {
    final authCubit = context.read<AuthCubit>();
    final email = authCubit.emailcontroller.text.trim();
    final password = authCubit.passwordcontroller.text.trim();

    final emailValidation = AuthValidators.validateEmail(email);
    final passwordValidation = AuthValidators.validatePassword(password);

    setState(() {
      emailError = emailValidation;
      passwordError = passwordValidation;
      isValidated = emailError == null && passwordError == null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocListener<AuthCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginState) {
          Navigator.pushNamed(context, RouteName.bottomNav);
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.06),
                  child: Column(
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(AuthImages.logo,
                              height: size.width * 0.2),
                          AppText(
                              text: 'Sign In',
                              fontWeight: FontWeight.bold,
                              textSize: 20),
                        ],
                      ),

                      // Image
                      Image.asset(AuthImages.newsguy, height: size.width * 0.7),

                      // Email Field
                      AppTextField(
                        controller: context.read<AuthCubit>().emailcontroller,
                        text: 'Email',
                        focusNode: emailFocus,
                        onChanged: (_) => validateFields(),
                      ),
                      if (emailFocus.hasFocus && emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(emailError!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12)),
                          ),
                        ),

                      SizedBox(height: size.height * 0.02),

                      // Password Field
                      AppTextField(
                        text: 'Password',
                        controller:
                            context.read<AuthCubit>().passwordcontroller,
                        focusNode: passwordFocus,
                        obscureText: showpassword,
                        onChanged: (_) => validateFields(),
                        suffixIcon: GestureDetector(
                          onTap: () =>
                              setState(() => showpassword = !showpassword),
                          child: Icon(showpassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      if (passwordFocus.hasFocus && passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(passwordError!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12)),
                          ),
                        ),

                      SizedBox(height: size.height * 0.03),

                      // Login Button
                      AppButton(
                        onTap: isValidated
                            ? () => context.read<AuthCubit>().login()
                            : null,
                        text: "Login",
                        buttonColor: isValidated
                            ? AppColors.primaryColor2
                            : const Color.fromARGB(248, 230, 230, 230),
                      ),

                      // Forgot password text
                      Padding(
                        padding: EdgeInsets.only(top: size.width * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText(
                              text: 'Forgot Password?',
                              textSize: 12,
                              color: AppColors.lightGreyColor,
                            ),
                          ],
                        ),
                      ),

                      // Register prompt
                      Padding(
                        padding: EdgeInsets.only(top: size.width * 0.07),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: 'No account yet? Click ',
                                  style: TextStyle(
                                      color: AppColors.lightGreyColor)),
                              TextSpan(
                                text: 'here',
                                style: TextStyle(color: AppColors.redPatch),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, RouteName.signUp);
                                  },
                              ),
                              TextSpan(
                                  text: ' to register ',
                                  style: TextStyle(
                                      color: AppColors.lightGreyColor)),
                            ],
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
      ),
    );
  }
}
