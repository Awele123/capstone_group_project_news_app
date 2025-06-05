import 'dart:convert';
import 'dart:developer';

import 'package:capstone_news_app/data/news_repo.dart';
import 'package:capstone_news_app/models/news.models.dart';
import 'package:capstone_news_app/models/user.model.dart';
import 'package:capstone_news_app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState>{
  final NewsRepo newsRepo;
    NewsCubit(this.newsRepo) : super(NewsInitialState());
   
  Future<void> fetchNews() async {
    emit(NewsFetchingState());
    try {
      final response = await newsRepo.fetchNews();
      log(response.body.toString());
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        
          final newsJson = body['news'];

      final news = News.fromJson(newsJson);
        log('Fetched news: $body');
        emit(NewsFetchedState(news: news));
      } else {
        Utils.showTopSnackBar(message: body['message']);
        emit(const NewsErrorState(message: 'error'));
      }
    } catch (e) {
      emit(const NewsErrorState(message: 'error'));
      log('notupdate$e');
    }
  }
}