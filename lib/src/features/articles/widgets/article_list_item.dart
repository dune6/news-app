import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/src/features/app/util/icons.dart';

class ArticleListItem extends StatelessWidget {
  final String imageLink;
  final String title;

  const ArticleListItem(
      {Key? key, required this.imageLink, required this.title})
      : super(key: key);

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
            child: Image.asset(
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
              imageLink,
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
                        'A Simple Trick For Creating Color Palettes Quickly',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                        onPressed: () {}, icon: NewsIcons.favouritesUnselected)
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
