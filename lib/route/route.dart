import 'package:capstone_news_app/models/news.model.dart';
import 'package:capstone_news_app/pages/authentication/sign_in.dart';
import 'package:capstone_news_app/pages/authentication/sign_up.dart';
import 'package:capstone_news_app/pages/home/homepage.dart';
import 'package:capstone_news_app/pages/home/profile/profile.dart';
import 'package:capstone_news_app/pages/search/search.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/bottom_nav.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/news_details.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homePage:
        return MaterialPageRoute(builder: (_) => const Homepage());
      case RouteName.signUp:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case RouteName.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case RouteName.bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNav());
      case RouteName.newsDetails:
        final news = settings.arguments as NewsModel;
        return MaterialPageRoute(
          builder: (_) => NewsDetails(news: news),
        );
      case RouteName.search:
        return MaterialPageRoute(builder: (_) => Search());
      case RouteName.profile:
        return MaterialPageRoute(builder: (_) => Profile());

      // Add other routes here as needed
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
