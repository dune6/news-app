part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigationToArticlesEvent extends NavigationEvent {}

class NavigationToCategoriesEvent extends NavigationEvent {}

class NavigationToFavouritesEvent extends NavigationEvent {}

class NavigationToUserEvent extends NavigationEvent {}

enum NavPages { articles, categories, favourites, user }

extension NavPagesExtension on NavPages {
  NavigationEvent get getEvent {
    switch (this) {
      case NavPages.articles:
        return NavigationToArticlesEvent();
      case NavPages.categories:
        return NavigationToCategoriesEvent();
      case NavPages.favourites:
        return NavigationToFavouritesEvent();
      case NavPages.user:
        return NavigationToUserEvent();
    }
  }
}
