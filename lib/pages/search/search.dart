import 'package:capstone_news_app/constants/home_images.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/bottom_nav.dart';
import 'package:flutter/material.dart';

// void main() => runApp(NewsExploreApp());

// class NewsExploreApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Poppins',
//       ),
//       home: Search(),
//     );
//   }
// }

class Search extends StatelessWidget {
  final List<String> trendingTags = [
    'Biden', 'Kanye West', 'Trump',
    'Tinubu in paris', 'The wall of China',
    'Davido Album', 'Sinner', 'Covid19'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: AppText(
          
          text:'Explore',
        
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            textSize: 25,
          
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
         leading:IconButton(icon: Icon(Icons.arrow_back),onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
         },) //Icon(Icons.arrow_back, color: Color(0xFF000000)),
        // actions: [Icon(Icons.notifications_none, color: Color(0xFF000000))],
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'See what’s happening',
                hintStyle: TextStyle(color: Color(0xFF948B8B)),
                suffixIcon: Icon(Icons.search, color: Color(0xFF948B8B)),
                filled: true,
                fillColor: Color.fromARGB(24, 226, 222, 222),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Read more ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000),
                ),
                children: [
                  TextSpan(text: 'news ', style: TextStyle(color: Color(0xFF62B7D5))),
                  TextSpan(text: 'and see what’s happening\naround the '),
                  TextSpan(text: 'world', style: TextStyle(color: Color(0xFF62B7D5))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Everyone is searching....",
              style: TextStyle(color: Color(0xFF948B8B)),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: trendingTags.map((tag) =>
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(153, 183, 226, 245),
                        blurRadius: 2,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Chip(
                    label: Text(tag),
                    backgroundColor: const Color.fromARGB(255, 255, 254, 254),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                      side: BorderSide(color: Colors.transparent, width: 0),
                    ),
                  ),
                ),
              ).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Top Search",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 19,
                color: Color(0xFF000000),
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.asset(
                    HomeImages.joe,
                    // height: 275,
                    // width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    //width: double.infinity,
                    padding: EdgeInsets.all(12),
                    
                    child: Text(
                      'Joe Biden relegated to back of world leaders section at pope’s funeral',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}