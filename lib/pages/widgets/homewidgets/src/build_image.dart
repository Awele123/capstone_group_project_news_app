part of '../../../home/homepage.dart';

class BuildImage extends StatefulWidget {
  const BuildImage({
    super.key,
    required this.context,
    required this.image,
    required this.index,
    required this.text,
  });

  final BuildContext context;
  final String image, text;
  final int index;

  @override
  State<BuildImage> createState() => _BuildImageState();
}

class _BuildImageState extends State<BuildImage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.08),
        child: Container(
          width: size.width,
          height: size.height * 0.29,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.08),
            image: DecorationImage(
              image: AssetImage(widget.image),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.05),
                    child: GestureDetector(
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
                        isBookmarked
                            ? Icons.bookmark_added_outlined
                            : Icons.bookmark_outline_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: size.height * 0.03,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AppText(
                    textAlign: TextAlign.center,
                    maxline: 2,
                    text: widget.text,
                    textSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
