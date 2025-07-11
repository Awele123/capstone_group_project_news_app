// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/constants/nav_images.dart';
import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/cubits/news_cubit.dart';
import 'package:capstone_news_app/pages/home/profile/profile.dart';
import 'package:capstone_news_app/pages/widgets/menu_bar/about.dart';
import 'package:capstone_news_app/pages/widgets/menu_bar/terms_cond.dart';
import 'package:capstone_news_app/repos/news_repo.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/global_widgets/app_textfield.dart';
import 'package:capstone_news_app/models/news.model.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/news_details.dart';
import 'package:capstone_news_app/route/routename.dart';
//import 'package:capstone_news_app/pages/widgets/homewidgets/src/bottom_nav.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
part '../widgets/homewidgets/src/build_image.dart';
part '../widgets/homewidgets/src/buildindicator.dart';
part '../widgets/homewidgets/src/news_list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

bool isBookmarked = false;
bool showAllRecommendations = false;

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final watchauth = context.watch<AuthCubit>();
    String fullName = watchauth.user.name ?? '';
    String firstName = fullName.split(' ').first;
    return BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
      if (state is NewsFetchingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NewsFetchedState) {
        final newsList = state.news;

        return SafeArea(
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              extendBodyBehindAppBar: false,
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsets.all(
                    size.width * 0.02,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(size.width * 0.02),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                    ),
                    child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(NavImages.editProfile)),
                  ),
                ),
                title: Column(
                  children: [
                    AppText(text: 'Hi $firstName,', textSize: 12),
                    AppText(
                      text: 'Welcome',
                      textSize: 12,
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.notifications_outlined),
                        SizedBox(width: size.width * 0.02),

// PopupMenuButton<String>(
//                           icon: Icon(Icons.menu),
//                           onSelected: (String selected) {
//                             switch (selected) {
//                               case 'Politics':
// Navigator.push(context, MaterialPageRoute(builder: (context)=> PoliticsScreen()))

//                             }
//                           },

                        GestureDetector(
                          onTapDown: (TapDownDetails details) async {
                            final selected = await showMenu<String>(
                              context: context,
                              position: RelativeRect.fromLTRB(
                                details.globalPosition.dx,
                                details.globalPosition.dy,
                                0,
                                0,
                              ),
                              items: [
                                PopupMenuItem<String>(
                                  // value: 'Politics',
                                  child: Text('Profile'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile()));
                                  },
                                ),
                                PopupMenuItem<String>(
                                  //value: 'Sports',
                                  child: Text('About'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AboutScreen()));
                                  },
                                ),
                                PopupMenuItem<String>(
                                  //value: 'Entertainment',
                                  child: Text('Terms'),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermsAndConditionsScreen()));
                                  },
                                ),
                             
                              ],
                            );

                            if (selected != null) {
                              // Handle selection (you can navigate or filter content here)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Selected: $selected')),
                              );
                            }
                          },
                          child: Icon(Icons.menu),
                          // SizedBox(width: size.width * 0.02),
                        )
                      ],
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.07),
                      child: AppTextField(
                        text: 'Search',
                        suffixIcon: Icon(Icons.search),
                        radius: 50,
                        onChanged: (query) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        // horizontal: size.width * 0.06,
                        vertical: size.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AppText(
                                text: 'Trending',
                                fontWeight: FontWeight.bold,
                                textSize: 11.5,
                                color: AppColors.activeIndicatorColor,
                              ),
                              Positioned(
                                bottom: -4,
                                left: 0,
                                right: 0,
                                child: Container(
                                    height: 2,
                                    color: AppColors.activeIndicatorColor),
                              ),
                            ],
                          ),
                          AppText(
                            text: 'Politics',
                            textSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            text: 'Sport',
                            textSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            text: 'Entertainment',
                            textSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText(
                            text: 'Arts',
                            textSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: newsList.length,
                          itemBuilder: (context, index, realIndex) {
                            final news = newsList[index];
                            final imageUrl = news.image;
                            final text = news.title;
                            return Stack(
                              children: [
                                BuildImage(
                                  context: context,
                                  image: imageUrl,
                                  text: text,
                                  index: index,
                                ),
                              ],
                            );
                          },
                          options: CarouselOptions(
                            height: size.width * 0.5,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.05,
                        ),
                        BuildIndicator(
                            activeIndex: activeIndex,
                            count: homeImageList.length),
                      ],
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'Recommendation',
                            textSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllRecommendations = true;
                              });
                            },
                            child: AppText(
                              text: 'View All',
                              textSize: 16,
                              color: AppColors.activeIndicatorColor,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                          vertical: size.width * 0.05),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: showAllRecommendations
                            ? newsList.length
                            : (newsList.length >= 3 ? 3 : newsList.length),
                        itemBuilder: (context, index) {
                          final news = newsList[index];
                          final formattedTime = news.updatedAt != null
                              ? timeago.format(news.updatedAt!)
                              : '';
                          return NewsList(
                            news: newsList[index],
                            image: Image.network(
                              news.image,
                              width: size.width * 0.27,
                              height: size.width * 0.27,
                              fit: BoxFit.cover,
                            ),
                            heading: news.category,
                            subheading: news.content,
                            time: formattedTime,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is NewsErrorState) {
        return Center(child: Text(state.message));
      } else {
        return const Center(
          child: Text("No news to display"),
        );
      }
    });
  }
}
