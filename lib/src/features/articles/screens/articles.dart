import 'package:flutter/material.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/articles/widgets/article_list_item.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 72, left: 20, right: 19),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Browse',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            'Discover things of this world',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 32,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              hintText: 'Search',
              fillColor: NewsColors.greyLighter,
              filled: true,
            ),
          ),
          ArticleListItem(),
        ],
      ),
    );
  }
}
