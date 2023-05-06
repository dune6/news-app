import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/app/pages/home_screen.dart';
import 'package:news_app/src/features/navigation/service/bloc/navigation_bloc.dart';

class NewsApplication extends StatelessWidget {
  const NewsApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ilya.voznesensky/news-app',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    );
  }
}
