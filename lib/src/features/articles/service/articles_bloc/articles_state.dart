part of 'articles_bloc.dart';

enum ArticlesStatus { initial, success, failure }

class ArticlesState extends Equatable {
  const ArticlesState({
    this.status = ArticlesStatus.initial,
    this.articles = const <Article>[],
    this.categories = const <Section>[Section.home],
  });

  final ArticlesStatus status;
  final List<Article> articles;
  final List<Section> categories;

  ArticlesState copyWith({
    ArticlesStatus? status,
    List<Article>? articles,
    List<Section>? categories,
  }) {
    return ArticlesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() {
    return '''ArticleState { status: $status, Articles: ${articles.length}, categories: ${categories.length} }''';
  }

  @override
  List<Object> get props => [status, articles, categories];
}
