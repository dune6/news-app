import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/app/util/icons.dart';
import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/articles/service/articles_bloc/articles_bloc.dart';
import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';
import 'package:news_app/src/features/articles/widgets/article_list.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final GroupButtonController _groupButtonController =
      GroupButtonController(selectedIndex: 0);
  final List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    context.read<ArticlesBloc>().add(ArticlesFetched(section: Section.home));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 72),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Browse',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  'Discover things of this world',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.labelMedium,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    fillColor: NewsColors.greyLighter,
                    filled: true,
                    prefixIcon: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 12),
                      child: NewsIcons.search,
                    ),
                    suffixIcon: Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 12),
                      child: NewsIcons.microphone,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SingleChildScrollView(
            primary: false,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.only(start: 20, end: 19),
            child: GroupButton(
              isRadio: true,
              options: GroupButtonOptions(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                buttonHeight: 32,
                buttonWidth: 81,
                selectedTextStyle: Theme.of(context).textTheme.titleSmall,
                unselectedTextStyle: Theme.of(context).textTheme.displaySmall,
                selectedColor: NewsColors.purplePrimary,
                unselectedColor: NewsColors.greyLighter,
                groupingType: GroupingType.row,
                spacing: 16,
              ),
              controller: _groupButtonController,
              enableDeselect: false,
              buttons: const [
                'Random',
                'Sports',
                'Art',
                'Gaming',
                'Fashion',
                'Nature'
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 19),
              child: BlocConsumer<ArticlesBloc, ArticlesState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == ArticlesStatus.initial) {
                    return const CircularProgressIndicator();
                  } else {
                    if (state.articles.isEmpty) {
                      return const Text('Empty articles list');
                    } else {
                      return Flexible(
                        child: ArticleListWidget(
                          articles: state.articles,
                        ),
                      );
                    }
                  }
                },
              )),
        ],
      ),
    );
  }
}
