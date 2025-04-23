import 'package:capstone_news_app/cubits/auth_cubit.dart';
import 'package:capstone_news_app/data/auth_repo.dart';
import 'package:capstone_news_app/pages/authentication/sign_in.dart';
import 'package:capstone_news_app/pages/home/homepage.dart';
import 'package:capstone_news_app/pages/widgets/homewidgets/src/bottom_nav.dart';
import 'package:capstone_news_app/route/app_route.dart';
import 'package:capstone_news_app/route/route.dart';
import 'package:capstone_news_app/route/routename.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => AuthCubit(AuthRepo()), child: const MyApp()));
  const MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UpNext',
      initialRoute: RouteName.signIn,
      navigatorKey: AppRoute.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}
