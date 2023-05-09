part of 'articles_bloc.dart';

abstract class ArticlesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ArticlesFetched extends ArticlesEvent {
  final Section section;

  ArticlesFetched({required this.section});
}

class FilterArticles extends ArticlesEvent {
  final String filter;

  FilterArticles({required this.filter});
}

class ArticlesSaveLocally extends ArticlesEvent {
  final List<Article> articles;

  ArticlesSaveLocally({required this.articles});
}

class ArticlesLoadLocally extends ArticlesEvent {}
