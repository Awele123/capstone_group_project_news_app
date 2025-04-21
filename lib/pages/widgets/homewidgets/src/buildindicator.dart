part of '../../../home/homepage.dart';

class BuildIndicator extends StatelessWidget {
  const BuildIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
  });

  final int activeIndex;
  final int count;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: ScrollingDotsEffect(
        activeDotColor: AppColors.activeIndicatorColor,
        dotColor: AppColors.inactiveIndicatorColor,
        smallDotScale: 1,
        dotHeight: size.width * 0.02,
        dotWidth: size.width * 0.02,
      ),
    );
  }
}
