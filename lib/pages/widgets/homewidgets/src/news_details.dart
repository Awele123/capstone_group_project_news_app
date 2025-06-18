import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/cubits/news_cubit.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/models/news.model.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsDetails extends StatefulWidget {
  final ImageProvider? imageheader;
  final Widget? newsLogo, centerImage;
  final String? newsTime;
  final String? newsTitle;
  final NewsModel news;
  final String? newsDescription, secondParagraph;
  final String? newsSource;

  const NewsDetails({
    super.key,
    required this.news,
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

class _NewsDetailsState extends State<NewsDetails> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final alreadyBookmarked = context
          .read<NewsCubit>()
          .bookmarkedNews
          .any((n) => n.id == widget.news.id);
      setState(() {
        isBookmarked = alreadyBookmarked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            width: double.infinity,
            height: size.height * 0.37,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.news.image),
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
                      text: widget.news.content,
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final cubit = context.read<NewsCubit>();
                            cubit.toggleBookmark(widget.news);
                            final updatedStatus =
                                cubit.isBookmarked(widget.news);
                            setState(() {
                              isBookmarked = updatedStatus;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(updatedStatus
                                    ? 'Added to Bookmarks'
                                    : 'Removed from Bookmarks'),
                              ),
                            );
                          },
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: AppColors.bookMarkColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // News Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                  child: AppText(
                    textAlign: TextAlign.justify,
                    textSize: 13,
                    maxline: 100,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                    text: widget.news.content,
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}
