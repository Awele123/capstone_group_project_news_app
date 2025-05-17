import 'package:capstone_news_app/constants/home_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Live',
              style: 
              GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              '*',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
               icon:  const Icon(
                  Icons.search_outlined,), onPressed: () {
                   
                  },
              ),
              const SizedBox(width: 20.0,),
              const Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Happening Now!',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Stack(
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(HomeImages.liveImage,
        height: 400, // Increased height
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
    // Optional: dark gradient to improve text readability
    Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.transparent,
          ],
        ),
      ),
    ),
    // Play icon and text on image
    const Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              size: 64,
              color: Colors.white,
            ),
            SizedBox(height: 50),
            Text(
              maxLines: 3,
              'AMVCA: Watch live feeds as Nigeria Celebrities stun in great fashion and style',
              textAlign: TextAlign.center,
              style: 
              TextStyle(
                fontSize: 18, // Larger font
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 4, color: Colors.black)],
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),

            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: const BoxDecoration(
                // border: Border.all(
                //     color: Color(0xFF5BBFD9),
                //     width: 2),
                //borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Live NOW',
                        style:
                         TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Image.asset(HomeImages.realMadrid,width: 60.0,),
                      const Text(
                        'Real Mardrid VS Barcelona',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          
                        ),
                      ),
                      Image.asset(HomeImages.barcelona,width:50.0,)
                    ],
                  ),

                  //SizedBox(height: 2,),
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'La Liga',
                        style: TextStyle(color: Color(0xFF5BBFD9)),
                      ),
                      //Spacer(),
                      Text(
                        '11/05/2025 (15:15 pm)',
                        style: TextStyle(color: Color(0xFF5BBFD9)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 225, 233, 235),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Live NOW', 
                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('President Tinubu National address',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),),
                        ],
                      ),
                      //SizedBox(height: 2,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Arise Tv',
                                 style: TextStyle(color: Color(0xFF5BBFD9)),),
                                //Spacer(),
                                Text('31/05/2025 (07:00 pm)',
                                 style: TextStyle(color: Color(0xFF5BBFD9)),),
                              ],
                            )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 225, 233, 235),
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Live NOW',
                  style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('A New pope has been elected',
                        style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                        ),
                      ],
                        
                      ),
                       Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('For News',
                                 style: TextStyle(color: Color(0xFF5BBFD9)),),
                                //Spacer(),
                                Text('12/05/2025 (11:00 pm)',
                                 style: TextStyle(color: Color(0xFF5BBFD9)),),
                              ],
                            )
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