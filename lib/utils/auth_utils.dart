import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:capstone_news_app/models/user.model.dart';

class AuthUtils {
  static const String _userKey = 'data';
  static const _bearerTokenKey = 'bearer_token';

  Future<void> storeBearerToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bearerTokenKey, token);
  }

  // Method to get the stored bearer token
  Future<String?> getBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bearerTokenKey);
  }

  Future<String?> readBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_bearerTokenKey);
  }

  Future<void> clearBearerToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_bearerTokenKey);
  }

  // Save user info to local storage
  Future<void> saveUserInfo(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  // Read user info from local storage
  Future<UserModel?> readUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  // Clear saved user info (e.g. on logout)
  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
