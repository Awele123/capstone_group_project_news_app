part of '../../../home/homepage.dart';

class NewsList extends StatelessWidget {
  const NewsList(
      {super.key,
      this.image,
      this.heading,
      this.subheading,
      this.newSource,
      this.time,
        required this.news,
      this.onTap});

  final Widget? image;
   
  final NewsModel news;
  final String? heading;
  final String? subheading;
  final String? newSource;
  final Function? onTap;
  final String? time;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
   
    return Padding(
      padding: EdgeInsets.only(bottom: size.width * 0.05),
      child: GestureDetector(
        onTap: () {
         onTap != null
    ? onTap!()
    : Navigator.pushNamed(
        context,
        RouteName.newsDetails,
        arguments: news,
      );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(size.width * 0.04),
              child: image ??
                  Image.asset(
                    HomeImages.tinubu,
                    width: size.width * 0.27,
                    height: size.width * 0.27,
                    fit: BoxFit.cover,
                  ),
            ),
            SizedBox(
              width: size.width * 0.03,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: heading ?? 'Politics',
                    textSize: 12,
                    color: AppColors.lightGreyColor,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  AppText(
                    text: subheading ??
                        'President Tinubu jets to Paris amid threatening insecurities in Nigeria',
                    textSize: 16,
                    maxline: 3,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                       
                        text: newSource ?? 'UpNext',
                        textSize: 11,
                        color: AppColors.lightGreyColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.08),
                        child: AppText(
                          text: time ?? '24 hours Ago',
                          textSize: 12,
                          color: AppColors.lightGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
