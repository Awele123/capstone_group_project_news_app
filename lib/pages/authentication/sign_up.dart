import 'dart:developer';

import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/asset_images.dart';
import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, this.controller});
  final TextEditingController? controller;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passToggle = false;
  bool confirmPassToggle = false;
  bool isFormValid = false;

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  bool nameTouched = false;
  bool emailTouched = false;
  bool passwordTouched = false;
  bool confirmPasswordTouched = false;

  @override
  void initState() {
    super.initState();
    nameFocus.addListener(() {
      if (nameFocus.hasFocus) {
        setState(() => nameTouched = true);
      }
    });
    emailFocus.addListener(() {
      if (emailFocus.hasFocus) {
        setState(() => emailTouched = true);
      }
    });
    passwordFocus.addListener(() {
      if (passwordFocus.hasFocus) {
        setState(() => passwordTouched = true);
      }
    });
    confirmPasswordFocus.addListener(() {
      if (confirmPasswordFocus.hasFocus) {
        setState(() => confirmPasswordTouched = true);
      }
    });
  }

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  void validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return BlocListener<AuthCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is RegisteredState) {
          log("✅ RegisteredState triggered!");
          setState(() {
            isLoading = false;
          });
          Navigator.pushNamed(context, RouteName.bottomNav);
        } else if (state is ErrorState) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(AuthImages.logo),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
          child: Form(
            key: _formKey,
            onChanged: validateForm,
            child: Column(
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: authCubit.namecontroller,
                  focusNode: nameFocus,
                  validator: (value) {
                    if (!nameTouched) return null;
                    return (value == null || value.isEmpty)
                        ? 'Name is required'
                        : null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF0FBFF),
                    labelText: 'Name',
                    errorStyle:
                        const TextStyle(fontSize: 10, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: authCubit.emailcontroller,
                  focusNode: emailFocus,
                  validator: (value) {
                    if (!emailTouched) return null;
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^\S+@\S+\.\S+$').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFF0FBFF),
                    labelText: 'Email',
                    errorStyle:
                        const TextStyle(fontSize: 10, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: authCubit.passwordcontroller,
                  focusNode: passwordFocus,
                  obscureText: !passToggle,
                  validator: (value) {
                    if (!passwordTouched) return null;
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                      return 'Include at least one uppercase letter';
                    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                      return 'Include at least one lowercase letter';
                    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                        .hasMatch(value)) {
                      return 'Include at least one special character';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off,
                        size: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF0FBFF),
                    labelText: 'Password',
                    errorStyle:
                        const TextStyle(fontSize: 10, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: authCubit.confirmPasswordController,
                  focusNode: confirmPasswordFocus,
                  obscureText: !confirmPassToggle,
                  validator: (value) {
                    if (!confirmPasswordTouched) return null;
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != authCubit.passwordcontroller.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          confirmPassToggle = !confirmPassToggle;
                        });
                      },
                      child: Icon(
                        confirmPassToggle
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 15.0,
                        color: Colors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF0FBFF),
                    labelText: 'Confirm Password',
                    errorStyle:
                        const TextStyle(fontSize: 10, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isLoading || !isFormValid
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              authCubit.register();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoading
                          ? Colors.grey
                          : (isFormValid
                              ? AppColors.primaryColor2
                              : const Color.fromARGB(248, 230, 230, 230)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Sign Up',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
