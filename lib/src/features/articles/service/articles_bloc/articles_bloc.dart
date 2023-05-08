import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';

part 'articles_event.dart';

part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository articlesRepository;

  ArticlesBloc({required this.articlesRepository})
      : super(const ArticlesState()) {
    on<ArticlesFetched>(
      _onArticlesFetched,
    );
  }

  Future<void> _onArticlesFetched(
      ArticlesFetched event, Emitter<ArticlesState> emit) async {
    try {
      final articles = await articlesRepository.getArticles(event.section);
      return emit(state.copyWith(
        status: ArticlesStatus.success,
        articles: articles,
      ));
    } catch (_) {
      emit(state.copyWith(status: ArticlesStatus.failure));
    }
  }
}
