import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/features/app/util/icons.dart';
import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/articles/screens/aricle_info.dart';
import 'package:surf_logger/surf_logger.dart';

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
          Material(
            child: InkWell(
              onTap: () => Future.delayed(Duration.zero, () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleInfoScreen(
                      article: article,
                    ),
                  ),
                );
              }),
              child: SizedBox(
                height: 272,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  placeholder: (context, url) => Image.asset(
                      'assets/images/placeholder.png',
                      fit: BoxFit.fitWidth),
                  errorWidget: (context, url, error) {
                    return Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.fitWidth);
                  },
                  placeholderFadeInDuration: const Duration(seconds: 1),
                  fadeInDuration: const Duration(seconds: 1),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  imageUrl: article.multimedia[1].url,
                ),
              ),
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
                        child: Material(
                            child: InkWell(
                      onTap: () => Future.delayed(Duration.zero, () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleInfoScreen(
                              article: article,
                            ),
                          ),
                        );
                      }),
                      child: Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ))),
                    IconButton(
                      onPressed: () {
                        // todo add to favourite
                        Logger.d('add to favourite');
                      },
                      icon: NewsIcons.favouritesUnselected,
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
