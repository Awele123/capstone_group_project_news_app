import 'dart:convert';
import 'dart:developer';

import 'package:capstone_news_app/repos/auth_repo.dart';
import 'package:capstone_news_app/repos/news_repo.dart';
import 'package:capstone_news_app/models/news.model.dart';
import 'package:capstone_news_app/models/user.model.dart';
import 'package:capstone_news_app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState>{
  final NewsRepo newsRepo;
   List<NewsModel> _bookmarkedNews = [];
    NewsCubit(this.newsRepo) : super(NewsInitialState());
  

  Future<void> fetchNews() async {
    emit(NewsFetchingState());
    try {
      final response = await newsRepo.fetchNews();
      log(response.body.toString());
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
      final List<NewsModel> news = (body as List)
          .map((json) => NewsModel.fromJson(json))
          .toList();
        log('Fetched news: $news');
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

  Future<void> saveNews(String postId) async{
    emit(NewsSavingState());
    try {
      final response = await newsRepo.savePost(postId: postId);
      final body = jsonDecode(response.body);
      if (response.statusCode == 200){
        emit(NewsSavedState());
      }else {
        Utils.showTopSnackBar(message: body['message']);
        emit(FailedToSaveState());
      }
    } catch (e) {
        emit(const NewsErrorState(message: 'error'));
      log('notupdate$e');
    }
  }
  
 void toggleBookmark(NewsModel news) {
    if (_bookmarkedNews.any((n) => n.id == news.id)) {
      _bookmarkedNews.removeWhere((n) => n.id == news.id);
    } else {
      _bookmarkedNews.add(news);
    }
    emit(BookmarkedNewsUpdated(_bookmarkedNews));
  }
    void getBookmarkedNews() {
    emit(BookmarkedNewsUpdated(_bookmarkedNews));
  }

 
  bool isBookmarked(NewsModel news) {
    return _bookmarkedNews.any((n) => n.id == news.id);
  }
   List<NewsModel> get bookmarkedNews => _bookmarkedNews;
}
