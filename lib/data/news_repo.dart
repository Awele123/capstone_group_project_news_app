import 'dart:convert';
import 'dart:developer';
import 'package:capstone_news_app/constants/api_constants.dart';
import 'package:capstone_news_app/utils/auth_utils.dart';
import 'package:http/http.dart' as http;

class NewsRepo {
  
  // Fetch news
  Future<http.Response> fetchNews() async {
    final token = await AuthUtils().getBearerToken();
    final url = Uri.parse(ApiConstants.fetchNews);
    log("Fetching new with token: $token");
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  
}

