import 'package:capstone_news_app/constants/app_colors.dart';
import 'package:capstone_news_app/constants/home_images.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Function to launch LinkedIn URLs
  void _launchLinkedIn(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About UpNext'),
        backgroundColor: AppColors.primaryColor2,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                HomeImages.vanLogo,
                width: 40,
                height: 40,
              ),
              const SizedBox(height: 16),
              const Text(
                'UpNext',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text(
                'What is UpNext?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "UpNext is your smart companion for staying ahead of the news. Whether it's politics, entertainment, sports, or global headlines, UpNext delivers fresh, curated stories tailored to your interests — all in one seamless experience.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                "With features like article bookmarking, categorized content, and a clean modern interface, UpNext makes staying updated easier than ever.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 15),
              const Text(
                "This app is a capstone project from CodeAnt Technology Hub and Bedrock Ideas, built as part of a hands-on learning initiative focused on solving real-world problems through tech.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const Text(
                'Our Mission',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "We aim to make information accessible, relevant, and engaging. Whether it's politics, sports, entertainment or global trends — we bring the world to your fingertips.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.group, color: AppColors.blackColor),
                  const SizedBox(width: 15),
                  const Text(
                    "Meet the Team",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• Anyanwu Chidimma charity - Project Lead & Mobile Developer',
                  ),
                  GestureDetector(
                    onTap: () => _launchLinkedIn(
                        'https://www.linkedin.com/in/chidimma-anyanwu-998bab1b5'),
                    child: const Text(
                      'Linkedin',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.bookMarkColor,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('• Nwabuzor Awele Jessica - Lead Mobile Developer'),
                  GestureDetector(
                    onTap: () => _launchLinkedIn(
                        'https://linkedin.com/in/biotechwizengineer'),
                    child: const Text(
                      'Linkedin',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.bookMarkColor,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('• Elijah - Mobile Developer'),
                  GestureDetector(
                    onTap: () => _launchLinkedIn(
                        // add his linkedin link
                        'https://www.linkedin.com/in/ottah-elijah?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app'),
                    child: const Text(
                      'Linkedin',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.bookMarkColor,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('• Obinna - UI/UX Designer'),
                  GestureDetector(
                    onTap: () => _launchLinkedIn(
                        // add his linkedin link
                        'https://www.linkedin.com/in/obinna-david-chukwuemeka'),
                    child: const Text(
                      'Linkedin',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.bookMarkColor,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('• Victor - Backend Developer'),
                  GestureDetector(
                    onTap: () => _launchLinkedIn(
                        // add his linkedin link
                        'https://linkedin.com/in/biotechwizengineer'),
                    child: const Text(
                      'Linkedin',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.bookMarkColor,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Version: 1.0.0",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const Text(
                "Built with Flutter & Hive",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              const Text(
                "Powered by CodeAnt & Bedrock Ideas",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
