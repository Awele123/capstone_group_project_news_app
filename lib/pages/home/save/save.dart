import 'package:capstone_news_app/constants/home_images.dart';
import 'package:flutter/material.dart';

void main() {
 
}


class SavedNewsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> groupedNews = [
    {
      'dateLabel': 'Today',
      'articles': [
        {
          'image':  HomeImages.davido,
          'category': 'Entertainment',
          'title':
              'Nigerian Superstar Davido set to release fifth studio album titled “5IVE” on April 18th, set to set tracklist soon',
          'source': 'Rolling Stone',
          'timeAgo': '4 days ago',
        },
        {
          'image': HomeImages.footballer,
          'category': 'Sports',
          'title':
              'Super Osimhen can’t stop scoring as he hits his 28th for the season for table toppers Galatasary',
          'source': 'Complete Sports',
          'timeAgo': '2 days ago',
        },
      ],
    },
    {
      'dateLabel': 'Yesterday',
      'articles': [
        {

           'category': 'Politics',
          'image':HomeImages.patJohn,
         
          'title':
              'Why Goodluck Jonathan won’t run in 2027 – Patience Jonathan',
          'source': 'Vanguard',
          'timeAgo': '2 days ago',
        },
      ],
    },
    {
      'dateLabel': '03/12/2025',
      'articles': [
        {
          'image':HomeImages.simfub ,
          'category': 'Politics',
          'title':
              'Rivers crisis: What I told Fubara when he came begging – Wike',
          'source': 'Daily Post',
          'timeAgo': '2 days ago',
        },
        {
          'image': HomeImages.bolaAhmed,
          'category': 'Politics',
          'title':
              'President Tinubu jets to Paris amid threatening insecurities in Nigeria',
          'source': 'The Vanguard',
          'timeAgo': '24hrs ago',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
        actions: [
          const Icon(Icons.search),
          const SizedBox(width: 16),
          const Icon(Icons.notifications_none),
          const SizedBox(width: 16),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: groupedNews.length,
        itemBuilder: (context, index) {
          final group = groupedNews[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group['dateLabel'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...group['articles'].map<Widget>((article) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            article['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article['category'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                article['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${article['source']} • ${article['timeAgo']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
     
    );
  }
}