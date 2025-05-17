import 'dart:convert';
import 'dart:developer';
import 'package:capstone_news_app/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<http.Response> register({
    required String email,
    required String name,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse(ApiConstants.register);
    log("REGISTERING to URL: $url");

    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'name': name,
        'password': password,
        'confirmPassword': confirmPassword,
      }),
      headers:
          Headers.unAuthHeader(), // Remove Bearer token here for registration
    );
    return response;
  }

  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.login);
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  // Fetch user profile
  Future<http.Response> fetchUserProfile() async {
    final url = Uri.parse(ApiConstants.fetchUserProfile);
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }

  // Update user profile
  Future<http.Response> updateUserProfile({
    required String name,
    required String email,
    required String mobile,
    required String currentPassword,
    required String password,
  }) async {
    final url = Uri.parse(ApiConstants.updateUserProfile);

    final Map<String, String> data = {
      'name': name,
      'email': email,
      'mobile': mobile,
      'currentPassword': currentPassword,
      'password': password,
    };

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return response;
  }

  Future<http.Response> saveNews() async {
    final url = Uri.parse(ApiConstants.getsaveNews('643b8f1c4d2a0e3f5c9b7e6d'));
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
}
