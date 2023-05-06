import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/app/pages/home_screen.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/navigation/service/bloc/navigation_bloc.dart';

class NewsApplication extends StatelessWidget {
  const NewsApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ilya.voznesensky/news-app',
      theme: themeNewsApp,
      home: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    );
  }
}

ThemeData themeNewsApp = ThemeData(
    brightness: Brightness.light,
    primaryColor: NewsColors.purplePrimary,
    dividerColor: Colors.transparent,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: NewsColors.purplePrimary,
        onPrimary: NewsColors.purpleLighter,
        secondary: NewsColors.purpleLight,
        onSecondary: NewsColors.white,
        error: Colors.red,
        onError: NewsColors.white,
        background: NewsColors.greyLighter,
        onBackground: NewsColors.white,
        surface: NewsColors.greyLight,
        onSurface: NewsColors.white),
    fontFamily: 'SF Pro',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
          color: NewsColors.blackPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(
          color: NewsColors.blackPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600),
      bodySmall: TextStyle(
          color: NewsColors.greyPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400),
      titleLarge: TextStyle(
          color: NewsColors.blackPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
          color: NewsColors.greyPrimary,
          fontSize: 12,
          fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          color: NewsColors.greyPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500),
    ));
