import 'package:flutter/material.dart';
import 'package:news_app/src/features/articles/screens/articles.dart';

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
      home: const ArticlesScreen(),
    );
  }
}
