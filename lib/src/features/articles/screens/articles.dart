import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/app/util/icons.dart';
import 'package:news_app/src/features/articles/service/articles_bloc/articles_bloc.dart';
import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';
import 'package:news_app/src/features/articles/widgets/article_list.dart';
import 'package:surf_logger/surf_logger.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final GroupButtonController _groupButtonController =
      GroupButtonController(selectedIndex: 0);
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_filterArticles);
    _groupButtonController.addListener(_changedSection);
    if (context.read<ArticlesBloc>().articles.isEmpty) {
      context.read<ArticlesBloc>().add(ArticlesFetched(section: Section.home));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 72,
        ),
        ElevatedButton(
            onPressed: () {
              context.read<ArticlesBloc>().add(ArticlesLoadLocally());
            },
            child: const Text('load locally data')),
        Column(
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
                    controller: _textEditingController,
                    style: Theme.of(context).textTheme.labelMedium,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      hintText: 'Search',
                      fillColor: NewsColors.greyLighter,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 12),
                        child: NewsIcons.search,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 12),
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
                // onSelected: _changedSection,
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
                buttons: [
                  Section.home.section,
                  Section.sports.section,
                  Section.arts.section,
                  Section.business.section,
                  Section.fashion.section,
                  Section.food.section,
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 19),
                child: BlocBuilder<ArticlesBloc, ArticlesState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case ArticlesStatus.initial:
                        return const CircularProgressIndicator();
                      case ArticlesStatus.failure:
                        return const Text('Error!');
                      case ArticlesStatus.success:
                        return state.articles.isEmpty
                            ? const Text('No data')
                            : ArticleListWidget(
                                articles: state.articles,
                              );
                    }
                  },
                )),
          ],
        )
      ],
    );
  }

  // filter articles by text input
  void _filterArticles() {
    context
        .read<ArticlesBloc>()
        .add(FilterArticles(filter: _textEditingController.text));
  }

  void _changedSection() {
    _textEditingController.text = '';
    final index = _groupButtonController.selectedIndexes.last;
    Logger.d('Index pressed: $index');
    switch (index) {
      case 0:
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(section: Section.home));
        break;
      case 1:
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(section: Section.sports));
        break;
      case 2:
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(section: Section.arts));
        break;
      case 3:
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(section: Section.business));
        break;
      case 4:
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(section: Section.fashion));
        break;
      case 5:
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(section: Section.food));
        break;
    }
  }
}
