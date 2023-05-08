import 'package:flutter/material.dart';
import 'package:news_app/src/features/articles/domain/article.dart';

import 'article_list_item.dart';

class ArticleListWidget extends StatelessWidget {
  final List<Article> articles;

  const ArticleListWidget({Key? key, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: articles.length,
      itemExtent: 296,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      semanticChildCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: ArticleListItem(
            article: articles[index],
          ),
        );
      },
    );
  }
}
