import 'dart:convert';
import 'dart:developer';

import 'package:capstone_news_app/repos/auth_repo.dart';
import 'package:capstone_news_app/repos/news_repo.dart';
import 'package:capstone_news_app/models/news.model.dart';
import 'package:capstone_news_app/models/user.model.dart';
import 'package:capstone_news_app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo newsRepo;
  List<NewsModel> _bookmarkedNews = [];

  NewsCubit(this.newsRepo) : super(NewsInitialState()) {
    _loadBookmarks();
  }
  List<NewsModel> get bookmarkedNews => _bookmarkedNews;

  Future<void> fetchNews() async {
    emit(NewsFetchingState());
    try {
      final response = await newsRepo.fetchNews();
      log(response.body.toString());
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<NewsModel> news =
            (body as List).map((json) => NewsModel.fromJson(json)).toList();
        log('Fetched news: $news');
        // await _loadBookmarks();
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

  Future<void> saveNews(String postId) async {
    emit(NewsSavingState());
    try {
      final response = await newsRepo.savePost(postId: postId);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(NewsSavedState());
      } else {
        Utils.showTopSnackBar(message: body['message']);
        emit(FailedToSaveState());
      }
    } catch (e) {
      emit(const NewsErrorState(message: 'error'));
      log('notupdate$e');
    }
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('bookmarked_news');
    if (jsonList != null) {
      _bookmarkedNews = jsonList
          .map((item) => NewsModel.fromJson(json.decode(item)))
          .toList();
      emit(BookmarkedNewsUpdated(_bookmarkedNews));
    }
  }

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        _bookmarkedNews.map((n) => json.encode(n.toJson())).toList();
    await prefs.setStringList('bookmarked_news', jsonList);
  }

  void toggleBookmark(NewsModel news) async {
    final isAlreadyBookmarked = _bookmarkedNews.any((n) => n.id == news.id);
    if (isAlreadyBookmarked) {
      _bookmarkedNews.removeWhere((n) => n.id == news.id);
    } else {
      _bookmarkedNews.add(news);
    }
    await _saveBookmarks();
    emit(BookmarkedNewsUpdated(_bookmarkedNews));
  }

  bool isBookmarked(NewsModel news) {
    return _bookmarkedNews.any((n) => n.id == news.id);
  }

  void getBookmarkedNews() {
    emit(BookmarkedNewsUpdated(_bookmarkedNews));
  }

  //List<NewsModel> get bookmarkedNews => _bookmarkedNews;
}

Future<void> addBookmark(String itemId) async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? bookmarks = prefs.getStringList('bookmarks') ?? [];
  if (!bookmarks.contains(itemId)) {
    bookmarks.add(itemId);
    await prefs.setStringList('bookmarks', bookmarks);
  }
}

Future<List<String>> getBookmarks() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('bookmarks') ?? [];
}
