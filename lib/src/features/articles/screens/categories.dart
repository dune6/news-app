import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/articles/service/articles_bloc/articles_bloc.dart';
import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';
import 'package:surf_logger/surf_logger.dart';


/// Screen for select favourites topics
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // mock data
  static final List<Section> _list = [
    Section.food,
    Section.world,
    Section.fashion,
    Section.arts,
    Section.books,
    Section.sundayreview,
  ];

  final GroupButtonController _groupButtonsController = GroupButtonController();

  @override
  void initState() {
    super.initState();
    context.read<ArticlesBloc>().add((LoadCategories()));
    _groupButtonsController.selectIndexes(
        initSelectedIndexes(context.read<ArticlesBloc>().state.categories));
  }

  List<int> initSelectedIndexes(List<Section> categories) {
    List<int> indexes = [];
    categories.forEach((element) {
      if (_list.contains((element))) {
        indexes.add(_list.indexOf(element));
      }
    });
    Logger.d('Selected indexes: $indexes');
    return indexes;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticlesBloc, ArticlesState>(
      listener: (context, state) {
        Logger.d('Pulling categories: ${state.categories}');
        _groupButtonsController
            .selectIndexes(initSelectedIndexes(state.categories));
      },
      child: ListView(
        children: [
          const SizedBox(
            height: 72,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Categories',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      'Thousands of articles in each category',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    GroupButton(
                      controller: _groupButtonsController,
                      isRadio: false,
                      onSelected: (value, index, isSelected) {
                        final selected =
                            _groupButtonsController.selectedIndexes;

                        final stringsCategory = selected
                            .map((index) => _list[index])
                            .map((category) => category.section)
                            .toList();
                        Logger.d('Selected (sections): $stringsCategory');
                        context
                            .read<ArticlesBloc>()
                            .add(SaveCategories(categories: stringsCategory));
                      },
                      options: GroupButtonOptions(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        buttonHeight: 72,
                        buttonWidth: 160,
                        spacing: 16,
                        runSpacing: 16,
                        elevation: 2,
                        selectedTextStyle:
                            Theme.of(context).textTheme.titleSmall,
                        unselectedTextStyle:
                            Theme.of(context).textTheme.displaySmall,
                        selectedColor: NewsColors.purplePrimary,
                        unselectedColor: NewsColors.greyLighter,
                        groupingType: GroupingType.wrap,
                      ),
                      enableDeselect: false,
                      buttons: [
                        ..._list.map((e) =>
                            '${e.section[0].toUpperCase()}${e.section.substring(1)}')
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
