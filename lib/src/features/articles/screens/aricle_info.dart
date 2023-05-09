import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/articles/domain/article.dart';

class ArticleInfoScreen extends StatefulWidget {
  final Article article;

  const ArticleInfoScreen({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleInfoScreen> createState() => _ArticleInfoScreenState();
}

class _ArticleInfoScreenState extends State<ArticleInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border_outlined)),
              ],
              elevation: 0,
              forceElevated: true,
              expandedHeight: 384.0,
              collapsedHeight: 120,
              backgroundColor: Colors.white,
              snap: false,
              pinned: true,
              floating: false,
              iconTheme: const IconThemeData(color: NewsColors.blackDarker),
              flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    widget.article.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(shadows: [
                      Shadow(
                          color: Colors.black.withOpacity(1), blurRadius: 10),
                    ]),
                  ),
                  titlePadding:
                      const EdgeInsets.only(left: 20, right: 19, bottom: 40),
                  background: CachedNetworkImage(
                    placeholder: (context, url) => Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.fitHeight),
                    errorWidget: (context, url, error) {
                      return Image.asset('assets/images/placeholder.png',
                          fit: BoxFit.fitHeight);
                    },
                    fadeInDuration: const Duration(seconds: 1),
                    placeholderFadeInDuration: const Duration(seconds: 1),
                    fadeInCurve: Curves.easeOutExpo,
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                    imageUrl: widget.article.multimedia.first.url,
                  )),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 19, top: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.article.section,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.article.abstract,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: NewsColors.greyDarker),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.article.multimedia.last.caption,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: NewsColors.greyDarker),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.article.multimedia.last.copyright,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: NewsColors.greyDarker),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ]))
          ],
        ),
      ),
    );
  }
}
