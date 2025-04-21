// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/global_widgets/app_textfield.dart';
import 'package:capstone_news_app/global_widgets/app_button.dart';
import 'package:capstone_news_app/constants/asset_images.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

bool showpassword = true;

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.width * 0.06),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AuthImages.logo,
                        height: size.width * 0.2,
                      ),
                      AppText(
                        text: 'Sign In',
                        fontWeight: FontWeight.bold,
                        textSize: 25,
                      )
                    ],
                  ),
                  Image.asset(
                    AuthImages.newsguy,
                    height: size.width * 0.7,
                  ),
                  AppTextField(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AppTextField(
                    text: 'Password',
                    obscureText: showpassword,
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showpassword = !showpassword;
                          });
                        },
                        child: Icon(
                          showpassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.activeIndicatorColor,
                        )),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AppButton(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.bottomNav);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AppText(
                            text: 'Forgot Password?',
                            color: AppColors.lightGreyColor),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: size.width * 0.07),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            fontSize:
                                16, // Add the font size for the whole text if needed
                            color: Colors.black, // Default color for text
                          ),
                          children: [
                            TextSpan(
                              text: 'No account yet? Click ',
                              style: TextStyle(color: AppColors.lightGreyColor),
                            ),
                            TextSpan(
                              text: 'here',
                              style: TextStyle(color: AppColors.redPatch),
                            ),
                            TextSpan(
                              text: ' to register ',
                              style: TextStyle(color: AppColors.lightGreyColor),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
