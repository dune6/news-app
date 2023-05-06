part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationArticlesState extends NavigationState {}

class NavigationCategoriesState extends NavigationState {}

class NavigationFavouritesState extends NavigationState {}

class NavigationUserState extends NavigationState {}
