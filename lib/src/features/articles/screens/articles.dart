import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  static int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const SafeArea(
            child: Center(
          child: FlutterLogo(),
        )),
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
                onTap: _onItemTapped,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 15,
                type: BottomNavigationBarType.fixed,
              ),
            )));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
