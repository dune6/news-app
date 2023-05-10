import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';
import 'package:news_app/src/features/app/util/colors.dart';
import 'package:news_app/src/features/app/util/icons.dart';
import 'package:news_app/src/features/articles/service/articles_bloc/articles_bloc.dart';
import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';
import 'package:news_app/src/features/articles/widgets/article_list.dart';
import 'package:surf_logger/surf_logger.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final GroupButtonController _groupButtonController =
      GroupButtonController(selectedIndex: 0);
  final TextEditingController _textEditingController = TextEditingController();
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(_filterArticles);
    _groupButtonController.addListener(_changedSection);

    // watch connection
    _subscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);

    // init connection for articles
    initConnectivity();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      Logger.e('Couldn\'t check connectivity status ', e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.none:
        Logger.d('Connection is ${result.name}');
        context.read<ArticlesBloc>().add(ArticlesLoadLocally());
        break;
      default:
        Logger.d('Connection is ${result.name}');
        context
            .read<ArticlesBloc>()
            .add(ArticlesFetched(selectedCategoriesIndex: 0));
        break;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        const SizedBox(
          height: 72,
        ),
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
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(start: 20, end: 19),
              child: GroupButton(
                isRadio: true,
                // onSelected: _changedSection,
                options: GroupButtonOptions(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  buttonHeight: 32,
                  textPadding: const EdgeInsets.symmetric(horizontal: 5),
                  selectedTextStyle: Theme.of(context).textTheme.titleSmall,
                  unselectedTextStyle: Theme.of(context).textTheme.displaySmall,
                  selectedColor: NewsColors.purplePrimary,
                  direction: Axis.horizontal,
                  unselectedColor: NewsColors.greyLight.withOpacity(0.1),
                  groupingType: GroupingType.row,
                  spacing: 16,
                ),
                controller: _groupButtonController,
                enableDeselect: false,
                buttons: [
                  ...context
                      .read<ArticlesBloc>()
                      .state
                      .categories
                      .map((e) => e.section)
                      .map((e) => '${e[0].toUpperCase()}${e.substring(1)}')
                      .toList()
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

  void _changedSection() async {
    _textEditingController.text = '';
    final index = _groupButtonController.selectedIndexes.last;

    if ((await Connectivity().checkConnectivity()) == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Turn on internet'),
        backgroundColor: Colors.red,
      ));
    } else {
      Logger.d('Index pressed: $index');
      context
          .read<ArticlesBloc>()
          .add(ArticlesFetched(selectedCategoriesIndex: index));
    }
  }
}
