import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:capstone_news_app/constants/api_constants.dart';
import 'package:capstone_news_app/repos/auth_repo.dart';
import 'package:capstone_news_app/models/user.model.dart';
import 'package:capstone_news_app/utils/auth_utils.dart';
import 'package:capstone_news_app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

String bearerToken = "";
bool showpasword = false;

class AuthCubit extends Cubit<AuthenticationState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthenticationInitialState());

  final namecontroller = TextEditingController();
  UserModel user = UserModel();
  final emailcontroller = TextEditingController();
  final mobileController = TextEditingController();
  final newPasswordController = TextEditingController();
  final passwordcontroller = TextEditingController();

  final confirmPasswordController = TextEditingController();

  register() async {
    emit(AuthLoadingState());
    try {
      var fullName = namecontroller.text.trim();
      log("email: ${emailcontroller.text.trim()}");
      log("password: ${passwordcontroller.text.trim()}");
      log("confirmPassword: ${confirmPasswordController.text.trim()}");

      var requestBody = json.encode({
        'email': emailcontroller.text.trim(),
        'name': fullName,
        'password': passwordcontroller.text.trim(),
        'confirmPassword': confirmPasswordController.text.trim(),
      });

      log("Request Body: $requestBody");
      log("REGISTERING to URL: ${ApiConstants.register}");

      final response = await authRepo.register(
        email: emailcontroller.text.trim(),
        name: fullName,
        confirmPassword: confirmPasswordController.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      log("STATUS: ${response.statusCode}");
      log("BODY: ${response.body}");

      final body = jsonDecode(response.body);
      log("Decoded JSON: $body");

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (body.containsKey('user')) {
          log("Registration successful!");
          user = UserModel.fromJson(body['user']);

          passwordcontroller.clear();
          confirmPasswordController.clear();
          namecontroller.clear();
          emailcontroller.clear();

          emit(RegisteredState());
          Utils.showTopSnackBar(message: body['message']);
          return;
        } else {
          log("User data is missing in response body");
          emit(AuthErrorState(error: 'User data not found in response'));
        }
      } else {
        log("Registration failed! Status Code: ${response.statusCode}");
        emit(AuthErrorState(error: 'Registration failed'));
        Utils.showTopSnackBar(message: body['message']);
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
      log("Registration Error: $e");
    }
  }

  login({bool useLocalStorage = false}) async {
    emit(AuthLoadingState());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (useLocalStorage) {
        List<String> loginInfo = prefs.getStringList('loginInfo') ?? [];
        if (loginInfo.isNotEmpty) {
          emailcontroller.text = loginInfo.first;
          passwordcontroller.text = loginInfo.last;
        }
      }

      log("Email: ${emailcontroller.text}, Password: ${passwordcontroller.text}");

      final response = await authRepo.login(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      log("STATUS: ${response.statusCode}");
      log("BODY: ${response.body}");

      final body = jsonDecode(response.body);

      if (response.statusCode == 400) {
        prefs.remove('loginInfo');
        if (body['type'] == Error403.no_password.name) {
          emit(NoPasswordState());
          return;
        }
        emit(AuthLoadedState());
        return;
      }

      if (response.statusCode == 401) {
        prefs.remove('loginInfo');
        emit(AuthErrorState(error: 'Login info not found'));
        Utils.showTopSnackBar(message: body['message']);
        return;
      }

      if (response.statusCode == 200) {
        String token = body['token'] ?? '';
        String message = body['message'] ?? 'Login successful';

        if (token.isNotEmpty) {
          await AuthUtils().storeBearerToken(token);
          bearerToken = token;
        } else {
          log("No token received in response");
        }

        // if (body.containsKey('user')) {
        //   user = UserModel.fromJson(body['user']);
        //   log('Assigned user from login data: ${user.name}');
        // }

        await prefs.setStringList('loginInfo', [
          emailcontroller.text.trim(),
          passwordcontroller.text.trim(),
        ]);
         await fetchUserprofie();
        log('Fetched profile data: $body');

        emailcontroller.clear();
        passwordcontroller.clear();
        Utils.showTopSnackBar(message: message);
        emit(LoginState());
      } else {
        //emit(AuthErrorState(error: ''));
        Utils.showTopSnackBar(
            message: body['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      log('login error: $e');
      emit(AuthErrorState(error: 'An error occurred during login'));
    }
  }
  
  admin({bool useLocalStorage = false}) async {
    emit(AuthLoadingState());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (useLocalStorage) {
        List<String> loginInfo = prefs.getStringList('loginInfo') ?? [];
        if (loginInfo.isNotEmpty) {
          emailcontroller.text = loginInfo.first;
          passwordcontroller.text = loginInfo.last;
        }
      }

      log("Email: ${emailcontroller.text}, Password: ${passwordcontroller.text}");

      final response = await authRepo.admin(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );

      log("STATUS: ${response.statusCode}");
      log("BODY: ${response.body}");

      final body = jsonDecode(response.body);

      if (response.statusCode == 400) {
        prefs.remove('loginInfo');
        if (body['type'] == Error403.no_password.name) {
          emit(NoPasswordState());
          return;
        }
        emit(AuthLoadedState());
        return;
      }

      if (response.statusCode == 401) {
        prefs.remove('loginInfo');
        emit(AuthErrorState(error: 'Login info not found'));
        Utils.showTopSnackBar(message: body['message']);
        return;
      }

      if (response.statusCode == 200) {
        String token = body['token'] ?? '';
        String message = body['message'] ?? 'Login successful';

        if (token.isNotEmpty) {
          await AuthUtils().storeBearerToken(token);
          bearerToken = token;
        } else {
          log("No token received in response");
        }

        // if (body.containsKey('user')) {
        //   user = UserModel.fromJson(body['user']);
        //   log('Assigned user from login data: ${user.name}');
        // }

        await prefs.setStringList('loginInfo', [
          emailcontroller.text.trim(),
          passwordcontroller.text.trim(),
        ]);
         await fetchUserprofie();
        log('Fetched profile data: $body');

        emailcontroller.clear();
        passwordcontroller.clear();
        Utils.showTopSnackBar(message: message);
        emit(LoginState());
      } else {
        //emit(AuthErrorState(error: ''));
        Utils.showTopSnackBar(
            message: body['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      log('login error: $e');
      emit(AuthErrorState(error: 'An error occurred during login'));
    }
  }

  String? email;

  bool updateUser = false;

  updateUserProfile() async {
    emit(AuthLoadingState());
    try {
      var fullName = namecontroller.text;

      final response = await authRepo.updateUserProfile(
        name: fullName,
        email: emailcontroller.text,
        newPassword: newPasswordController.text,
      );
      log(response.body.toString());
      final body = jsonDecode(response.body);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        newPasswordController.clear();
        Utils.showTopSnackBar(message: body['message']);
        user = UserModel.fromJson(body['user']);
        emit(ProfileUpdated());
        email = null; 
      } else {
        Utils.showTopSnackBar(message: body['message']);
        emit(const ErrorState(error: 'Error updating profile'));
      }
    } catch (e) {
      emit(const ErrorState(error: 'Error updating profile'));
      log('Profile update failed: $e');
    }
  }

  fetchUserprofie() async {
    emit(AuthLoadingState());
    try {
      final response = await authRepo.fetchUserProfile();
      log(response.body.toString());
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        user = UserModel.fromJson(body);
        log('Fetched profile data: $body');
        emit(ProfileFetched());
      } else {
        Utils.showTopSnackBar(message: body['message']);
        emit(const ErrorState(error: 'error'));
      }
    } catch (e) {
      emit(const ErrorState(error: 'error'));
      log('notupdate$e');
    }
  }

  Future<bool> logout() async {
    emit(AuthLoadingState());
    final url = Uri.parse(ApiConstants.logout);
    final headers = await Headers.unAuthHeader();

    try {
      final response = await http.post(url, headers: headers);
        log('Logout response: ${response.statusCode}');

      // 
      // 
        final prefs = await SharedPreferences.getInstance();
        await AuthUtils().clearBearerToken();
        await AuthUtils().clearUserInfo();
        //await prefs.remove('bearer_token');
        await prefs.remove('loginInfo');
        await prefs.remove('data');
        bearerToken = "";

        log('Token and user data removed');
        if (response.statusCode  == 200) {
        emit (LoggedOutState());
        return true;        //successful return
        }else {
          emit(AuthErrorState(error: 'Logout failed'));
          return false;
        }
            }
     catch (e) {
      emit(AuthErrorState(error: 'Logout error'));
        log('Logout error:$e');
        return false;
        }
  }

      //   final tokenAfter =prefs.getString('bearer_token');
      //   log('Token after logout: $tokenAfter'); // should log : null
      //   //clearTextForms();

      //   emit(AuthenticationInitialState());
      //   //log ('Logout tapped - starting logout process');
      //   return true;
      // } else {
      //   emit(AuthErrorState(error: 'Logout failed'));
      //   // log('Logout failed: ${response.statusCode} - ${response.body}');
      //   // return false;
      // }
     

      

  // gotoProfileEdit() {
  //   emit(AuthLoadingState());
  //   namecontroller.text = user.name.toString();
  //   emailcontroller.text = user.email!;

  //   emit(AuthLoadedState());
  // }

  clearTextForms() {
    Future.delayed(Duration.zero, () {
      emailcontroller.clear();
      passwordcontroller.clear();
      namecontroller.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      mobileController.clear();

      // user = UserModel();
    });
  }
}
