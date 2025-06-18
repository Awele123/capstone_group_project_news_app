import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  late VideoPlayerController _controller;
  bool _showPlayPauseIcon = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/Download.mp4');
     

    _controller.addListener(() {
      log("Controller isPlaying: ${_controller.value.isPlaying}");
      if (_controller.value.hasError) {
        print('Video error: ${_controller.value.errorDescription}');
      }
    });

    _controller.initialize().then((_) {
         _controller.setLooping(false);
      setState(() {});
    });
  }


  void _togglePlayPause()  {
   setState(() {
      if (!_controller.value.isInitialized) return;
     log("Controller isPlaying before toggle: ${_controller.value.isPlaying}");
    if (_controller.value.isPlaying) {
       _controller.pause();
      log("Tapped: now paused");
    } else {
      _controller.play();
      log("Tapped: now playing}");
    }

   });

  }

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
              style: GoogleFonts.poppins(
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
                icon: const Icon(Icons.search_outlined),
                onPressed: () {},
              ),
              const SizedBox(width: 20.0),
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
            const SizedBox(height: 16),
            _controller.value.isInitialized
                ? GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () => _togglePlayPause(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                        if (_showPlayPauseIcon)
                          const Icon(
                            Icons.play_circle_outline,
                            size: 100,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  )
                : Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),

            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: const BoxDecoration(
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
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Replace with your image if needed
                      Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Real Madrid VS Barcelona',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('La Liga',
                          style: TextStyle(color: Color(0xFF5BBFD9))),
                      Text('11/05/2025 (15:15 pm)',
                          style: TextStyle(color: Color(0xFF5BBFD9))),
                    ],
                  ),
                ],
              ),
            ),

            // Additional Live Cards (unchanged from your original)
            buildLiveCard(
              title: 'President Tinubu National address',
              channel: 'Arise Tv',
              time: '31/05/2025 (07:00 pm)',
            ),
            buildLiveCard(
              title: 'A New pope has been elected',
              channel: 'For News',
              time: '12/05/2025 (11:00 pm)',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLiveCard({
    required String title,
    required String channel,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 225, 233, 235)),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Live NOW',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(channel,
                      style: const TextStyle(color: Color(0xFF5BBFD9))),
                  Text(time, style: const TextStyle(color: Color(0xFF5BBFD9))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
