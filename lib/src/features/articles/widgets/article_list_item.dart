import 'package:flutter/material.dart';
import 'package:news_app/src/features/app/util/icons.dart';
import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/articles/screens/aricle_info.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;

  const ArticleListItem({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox(
            height: 272,
            width: MediaQuery.of(context).size.width,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              fadeInDuration: Duration(seconds: 1),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              image: article.multimedia[1].url,
            ),
          ),
          Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: NewsIcons.favouritesUnselected)
                  ]),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleInfoScreen(
                    article: article,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
