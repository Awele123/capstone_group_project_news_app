import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_news_app/models/news.model.dart';
import 'package:capstone_news_app/cubits/news_cubit.dart';
import 'package:capstone_news_app/global_widgets/app_text.dart';
import 'package:capstone_news_app/route/routename.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkedNews = context.watch<NewsCubit>().bookmarkedNews;
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.bottomNav);
                },
                child: Icon(Icons.arrow_back)),
            const Text('Saved Items'),
          ],
        ),
      ),
      body: bookmarkedNews.isEmpty
          ? const Center(child: Text("No bookmarks yet."))
          : ListView.builder(
              itemCount: bookmarkedNews.length,
              itemBuilder: (context, index) {
                final news = bookmarkedNews[index];
                return ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(news.image,
                          width: 80, height: 80, fit: BoxFit.cover)),
                  title: Text(news.title),
                  subtitle: Text(news.category),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.newsDetails,
                      arguments: news,
                    );
                  },
                );
              },
            ),
    );
  }
}
