import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                image: DecorationImage(
                  image: widget.imageheader ?? AssetImage(HomeImages.tinubu),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.04, left: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, RouteName.bottomNav),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04, vertical: 12),
                      child: AppText(
                        text: widget.newsTitle ??
                            'President Tinubu jets to Paris amid \n threatening insecurities in Nigeria',
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
                  horizontal: size.width * 0.04, vertical: size.height * 0.02),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });

                      if (isBookmarked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Added to Bookmarks'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Removed from Bookmarks'),
                          ),
                        );
                      }
                    },
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: AppColors.bookMarkColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: AppText(
                textAlign: TextAlign.justify,
                textSize: 13,
                maxline: 100,
                height: 1.6,
                fontWeight: FontWeight.w500,
                text: widget.newsDescription ??
                    'President Bola Ahmed Tinubu has departed Nigeria for Paris on an official visit, sparking public concern over his absence amid escalating insecurity across the country. The trip, according to the Presidency, is aimed at strengthening economic ties and attracting foreign investment. However, the timing has drawn criticism, as attacks by bandits in the North and rising violence in other regions continue to threaten national stability.',
              ),
            ),
            SizedBox(height: size.height * 0.02),
            widget.centerImage ??
                Image.asset(
                  HomeImages.bolaAhmed,
                  fit: BoxFit.cover,
                ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: AppText(
                textAlign: TextAlign.justify,
                textSize: 13,
                maxline: 100,
                height: 1.6,
                fontWeight: FontWeight.w500,
                text:
                    'Critics argue that the President’s presence is needed at home to address the worsening security situation. Presidential aides maintain that Tinubu remains in close contact with security chiefs and is committed to restoring peace. He is expected to return early next week.',
              ),
            ),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
