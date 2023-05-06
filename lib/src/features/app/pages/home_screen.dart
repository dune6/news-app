import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/src/features/articles/screens/articles.dart';
import 'package:news_app/src/features/navigation/service/bloc/navigation_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  topRight: Radius.circular(24), topLeft: Radius.circular(24)),
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
                    icon: SvgPicture.asset(
                        'assets/icons/navigation/unselected/navigation_articles.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/selected/navigation_articles.svg'),
                    label: 'Articles',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/navigation/unselected/navigation_categories.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/selected/navigation_categories.svg'),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/navigation/unselected/navigation_favourites.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/selected/navigation_favourites.svg'),
                    label: 'Favourites',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                        'assets/icons/navigation/unselected/navigation_user.svg'),
                    activeIcon: SvgPicture.asset(
                        'assets/icons/navigation/selected/navigation_user.svg'),
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
            )));
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
