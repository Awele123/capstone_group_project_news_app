import 'package:flutter/foundation.dart';

class ApiConstants {
  static const String baseUrl = "https://nextblogapi.onrender.com";

  static String get login => '$baseUrl/api/users/login';
  static String get register => '$baseUrl/api/users/register';
  static String get fetchUserProfile => '$baseUrl/users/profile';
  static String get updateUserProfile => '$baseUrl/users/profile';
  static String getsaveNews(String postId) =>
      '$baseUrl/users/save-post/$postId';
}

class Headers {
  static Map<String, String> authHeader(String bearerToken) => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $bearerToken",
      };

  static Map<String, String> unAuthHeader() => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
}
