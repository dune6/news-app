import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/app/di/app_di_container.dart';
import 'package:news_app/src/features/app/util/icons.dart';
import 'package:news_app/src/features/articles/screens/articles.dart';
import 'package:news_app/src/features/articles/service/articles_bloc/articles_bloc.dart';
import 'package:news_app/src/features/navigation/service/bloc/navigation_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int _selectedIndex = 0;
  static AppDiContainer diContainer = AppDiContainer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticlesBloc(
          articlesRepository: diContainer.getArticlesRepository(),
          preferencesProvider: diContainer.getLocalStorageRepository()),
      child: Scaffold(
          body: SafeArea(
              child: Center(child: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case NavigationArticlesState:
                  return const ArticlesScreen();
                case NavigationCategoriesState:
                  return Center(
                    child: Text(state.runtimeType.toString()),
                  );
                case NavigationFavouritesState:
                  return Center(
                    child: Text(state.runtimeType.toString()),
                  );
                case NavigationUserState:
                  return Center(
                    child: Text(state.runtimeType.toString()),
                  );
                default:
                  return const Center(
                    child: Text('Unsupported navigation'),
                  );
              }
            },
          ))),
          bottomNavigationBar: Container(
              height: 75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                ),
                child: BottomNavigationBar(
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: NewsIcons.articlesUnselected,
                      activeIcon: NewsIcons.articlesSelected,
                      label: 'Articles',
                    ),
                    BottomNavigationBarItem(
                      icon: NewsIcons.categoriesUnselected,
                      activeIcon: NewsIcons.categoriesSelected,
                      label: 'Categories',
                    ),
                    BottomNavigationBarItem(
                      icon: NewsIcons.favouritesUnselected,
                      activeIcon: NewsIcons.favouritesSelected,
                      label: 'Favourites',
                    ),
                    BottomNavigationBarItem(
                      icon: NewsIcons.userUnselected,
                      activeIcon: NewsIcons.userSelected,
                      label: 'User',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onBottomNavTapped,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 15,
                  type: BottomNavigationBarType.fixed,
                ),
              ))),
    );
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          context.read<NavigationBloc>().add(NavPages.articles.getEvent);
          break;
        case 1:
          context.read<NavigationBloc>().add(NavPages.categories.getEvent);
          break;
        case 2:
          context.read<NavigationBloc>().add(NavPages.favourites.getEvent);
          break;
        case 3:
          context.read<NavigationBloc>().add(NavPages.user.getEvent);
          break;
      }
    });
  }
}
