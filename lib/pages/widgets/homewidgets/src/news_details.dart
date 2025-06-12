import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/cubits/news_cubit.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/models/news.models.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetails extends StatefulWidget {
  final ImageProvider? imageheader;
  final Widget? newsLogo, centerImage;
  final String? newsTime;
  final String? newsTitle;

  final String? newsDescription, secondParagraph;
  final String? newsSource;

  const NewsDetails({
    super.key,
    this.imageheader,
    this.newsLogo,
    this.newsTime,
    this.newsSource,
    this.newsTitle,
    this.newsDescription,
    this.centerImage,
    this.secondParagraph,
    
  });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

bool isBookmarked = false;

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsFetchingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsFetchedState) {
          final newsList = state.news;

          return Scaffold(
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                  child: Column(children: [
                // Header Image Container
                Container(
                  width: double.infinity,
                  height: size.height * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(newsList.first.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.1),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.04,
                      left: size.width * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              RouteName.bottomNav,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                            vertical: 12,
                          ),
                          child: AppText(
                            text: newsList.first.content,
                            color: Colors.white,
                            textSize: 20,
                            maxline: 3,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Logo, source & bookmark
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                    vertical: size.height * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          widget.newsLogo ??
                              Image.asset(
                                HomeImages.vanLogo,
                                height: size.height * 0.06,
                                width: size.width * 0.1,
                              ),
                          SizedBox(width: size.width * 0.02),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: widget.newsSource ?? 'The Vanguard',
                                textSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              SizedBox(height: size.height * 0.005),
                              AppText(
                                text: widget.newsTime ?? '24hrs ago',
                                textSize: 8,
                                fontWeight: FontWeight.w200,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),

                      ListView.builder(
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final news = newsList[index];

                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<NewsCubit>()
                                  .saveNews(news.id); // ✅ now works

                              setState(() {
                                isBookmarked = !isBookmarked;
                              });

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(seconds: 1),
                                    content: Text(isBookmarked
                                        ? 'Added to Bookmarks'
                                        : 'Removed from Bookmarks'),
                                  ),
                                );
                              });
                            },
                            child: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: AppColors.bookMarkColor,
                            ),
                          );
                        },
                      ),
                      // News Description
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: AppText(
                          textAlign: TextAlign.justify,
                          textSize: 13,
                          maxline: 100,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                          text: newsList.first.content,
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Center Image
                      widget.centerImage ??
                          Image.asset(
                            HomeImages.bolaAhmed,
                            fit: BoxFit.cover,
                          ),

                      SizedBox(height: size.height * 0.02),

                      // Second Paragraph
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: AppText(
                          textAlign: TextAlign.justify,
                          textSize: 13,
                          maxline: 100,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                          text: widget.secondParagraph ??
                              'Critics argue that the President’s presence is needed at home...',
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),
                    ],
                  ),
                ),
              ])));
        } else if (state is NewsErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text("No news to display"));
        }
      },
    );
  }
}
