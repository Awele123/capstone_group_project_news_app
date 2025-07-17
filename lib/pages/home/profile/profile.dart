import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/global_widgets/app_button.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/global_widgets/app_textfield.dart';
import 'package:capstone_news_app/pages/authentication/sign_in.dart';
import 'package:capstone_news_app/pages/home/save/save.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/bottom_nav.dart';
import 'package:capstone_news_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController nameController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    final userName = context.read<AuthCubit>().user.name;
    nameController = TextEditingController(text: userName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchauth = context.watch<AuthCubit>();
    final size = MediaQuery.sizeOf(context);

    return BlocListener<AuthCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is LoggedOutState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => SignIn()),
              (route) => false,
            );
          }
          if (state is AuthErrorState) {
            Utils.showTopSnackBar(message: state.error);
          }
        },
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 230, 224, 224),
          body: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(HomeImages.background),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 40,
                      left: 16,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNav()));
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      )),
                  Positioned(
                    bottom: -5,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(HomeImages.avatar),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: AppTextField(
                            controller: nameController,
                            verticalWidth: 25,
                            fillColor: Colors.white,
                            readOnly: !isEditing,
                            suffixIcon: isEditing
                                ? null
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isEditing = true;
                                      });
                                    },
                                    child: Icon(Icons.edit,
                                        color: AppColors.bookMarkColor),
                                  ),
                            radius: 12,
                            initStyle: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildInfoCard(
                          size,
                          Row(
                            children: [
                              Icon(Icons.email, color: AppColors.bookMarkColor),
                              SizedBox(width: size.width * 0.03),
                              Expanded(
                                child: AppText(
                                  text: '${watchauth.user.email}',
                                  textSize: 22,
                                  color: AppColors.lightGreyColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SavedNewsScreen()),
                            );
                          },
                          child: _buildInfoCard(
                            size,
                            Row(
                              children: [
                                Icon(Icons.favorite,
                                    color: AppColors.bookMarkColor),
                                SizedBox(width: size.width * 0.03),
                                AppText(
                                  text: 'Favourite',
                                  textSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthCubit>().logout();
                          },
                          child: _buildInfoCard(
                            size,
                            Row(
                              children: [
                                Icon(Icons.logout,
                                    color: AppColors.bookMarkColor),
                                SizedBox(width: size.width * 0.03),
                                AppText(
                                  text: 'Log Out',
                                  textSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        AppButton(
                          width: 70.0,
                          text: 'Save',
                          buttonColor: AppColors.bookMarkColor,
                          onTap: () {
                            // final cubit = context.read<AuthCubit>();
                            context.read<AuthCubit>().namecontroller.text =
                                nameController.text.trim();
                            context.read<AuthCubit>().updateUserProfile();
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildInfoCard(Size size, Widget child) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 225, 233, 235)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.width * 0.04,
        ),
        child: child,
      ),
    );
  }
}
