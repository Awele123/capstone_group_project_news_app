// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/constants/nav_images.dart';
import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/cubits/news_cubit.dart';
import 'package:capstone_news_app/data/news_repo.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/global_widgets/app_textfield.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/news_details.dart';
import 'package:capstone_news_app/route/routename.dart';
//import 'package:capstone_news_app/pages/widgets/homewidgets/src/bottom_nav.dart';
import 'package:carousel_slider/carousel_slider.dart';
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



class _HomepageState extends State<Homepage> {
  @override
void initState() {
  super.initState();
    context.read<NewsCubit>().fetchNews();
}
  @override
  Widget build(BuildContext context) {


    
    final List<Map<String, String>> carouselItems = [
      {
        'image': HomeImages.footballer,
        'text': 'Super Oshimen Scores Again!',
      },
      {
        'image': HomeImages.footballer2,
        'text': 'Footballer Stars Shine Globally',
      },
      {
        'image': HomeImages.dangote,
        'text': 'Dangote’s Empire Expands',
      },
      {
        'image': HomeImages.davido,
        'text': 'Davido Drops New Album',
      },
      {
        'image': HomeImages.riri,
        'text': 'Rihanna speaks on making babies instead of music',
      },
      {
        'image': HomeImages.tinubu,
        'text': 'President Tinubu Heads to Paris amid nationwide crisis',
      },
    ];

    final size = MediaQuery.sizeOf(context);
    final watchauth = context.watch<AuthCubit>();
String fullName = watchauth.user.name ?? '';
String firstName = fullName.split(' ').first;
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state){

    if (state is NewsFetchingState){
      return const 
       Center(
        child: CircularProgressIndicator(),
      );
    
    } else if (state is NewsFetchedState){
      final news = state.news;
    
      return
      SafeArea(
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
                      onTap: () {}, child: Image.asset(NavImages.editProfile)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.notifications_outlined),
                    SizedBox(width: size.width * 0.02),
                    Icon(Icons.menu),
                    SizedBox(width: size.width * 0.02),
                  ],
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                    child: AppTextField(
                      text: 'Search',
                      suffixIcon: Icon(Icons.search),
                      radius: 50,
                      onChanged: (query) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: size.width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AppText(
                                text: 'Trending',
                                fontWeight: FontWeight.bold,
                                textSize: 12,
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
                          text: 'Arts',
                          textSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          text: 'Documentaries',
                          textSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: carouselItems.length,
                        itemBuilder: (context, index, realIndex) {
                          final image = carouselItems[index]['image']!;
                          final text = carouselItems[index]['text']!;
                          return Stack(
                            children: [
                              BuildImage(
                                context: context,
                                image: image,
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
                          activeIndex: activeIndex, count: homeImageList.length),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          text: 'Recommendation',
                          textSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          text: 'View All',
                          textSize: 16,
                          color: AppColors.activeIndicatorColor,
                          fontWeight: FontWeight.w400,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: size.width * 0.05),
                    child: Column(
                      children: [
                        NewsList(),
                        NewsList(
                          image: Image.network(
                            width: size.width * 0.27,
                            height: size.width * 0.27,
                            fit: BoxFit.cover,
                          news.image
                          ),
                          heading: news.category,
                          subheading:
                              news.content,
                          newSource: 'Complete sports',
                          // time: news.createdAt,
                        ),
                        NewsList(
                          image: Image.asset(
                            width: size.width * 0.27,
                            height: size.width * 0.27,
                            fit: BoxFit.cover,
                            HomeImages.davido,
                          ),
                          heading: 'Entertainment',
                          subheading:
                              'Nigerian Superstar Davido set to release fifth studio album titled “5IVE” on April 18th, set to set tracklist soon',
                          newSource: 'Rolling Stone',
                          time: '4 days ago',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    
      );
    }
      else if(state is NewsErrorState ){
        return Center(child: Text(state.message));
      }else {
        return  const Center(
          child: Text("No news to display"),
        );
      }
      }
    );
  }

}
