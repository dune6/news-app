part of 'articles_bloc.dart';

enum ArticlesStatus { initial, success, failure }

class ArticlesState extends Equatable {
  const ArticlesState({
    this.status = ArticlesStatus.initial,
    this.articles = const <Article>[],
  });

  final ArticlesStatus status;
  final List<Article> articles;

  ArticlesState copyWith({
    ArticlesStatus? status,
    List<Article>? articles,
  }) {
    return ArticlesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
    );
  }

  @override
  String toString() {
    return '''ArticleState { status: $status, Articles: ${articles.length} }''';
  }

  @override
  List<Object> get props => [status, articles];
}
