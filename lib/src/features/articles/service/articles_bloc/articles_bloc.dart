import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';
import 'package:news_app/src/features/local_storage/provider/shared_pref_provider.dart';
import 'package:surf_logger/surf_logger.dart';

part 'articles_event.dart';

part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final ArticlesRepository articlesRepository;
  final SharedPreferencesProvider preferencesProvider;

  List<Article> _filteredArticles = [];
  List<Article> _articles = [];

  List<Article> get articles => _articles;

  ArticlesBloc(
      {required this.articlesRepository, required this.preferencesProvider})
      : super(const ArticlesState()) {
    on<ArticlesFetched>(
      _onArticlesFetched,
      transformer: restartable(),
    );
    on<FilterArticles>(
      _onFilterArticles,
      transformer: restartable(),
    );
    on<ArticlesSaveLocally>(_saveArticlesLocally);
    on<ArticlesLoadLocally>(_giveArticlesLocally);
  }

  Future<void> _onArticlesFetched(
      ArticlesFetched event, Emitter<ArticlesState> emit) async {
    try {
      emit(state.copyWith(status: ArticlesStatus.initial));
      final articles = await articlesRepository.getArticles(event.section);
      if (const ListEquality().equals(_articles, articles)) {
        Logger.d('Lists are equal');
        emit(state.copyWith(status: ArticlesStatus.success));
      } else {
        // mock delayed for big data
        await Future.delayed(const Duration(seconds: 2));
        _articles = articles;
        emit(state.copyWith(
          status: ArticlesStatus.success,
          articles: _articles,
        ));
      }
      add(ArticlesSaveLocally(articles: _articles));
    } catch (_) {
      Logger.e(_.runtimeType.toString());
      emit(state.copyWith(status: ArticlesStatus.failure));
    }
  }

  Future<void> _onFilterArticles(
      FilterArticles event, Emitter<ArticlesState> emit) async {
    emit(state.copyWith(status: ArticlesStatus.initial));
    try {
      if (event.filter.isNotEmpty) {
        _filteredArticles = _articles
            .where((element) => element.title
                .toLowerCase()
                .contains(event.filter.trim().toLowerCase()))
            .toList();
        Logger.d(
            'Result filtered: ${_filteredArticles.map((e) => e.title).toList()}');
        emit(state.copyWith(
            status: ArticlesStatus.success, articles: _filteredArticles));
      } else {
        emit(state.copyWith(
          status: ArticlesStatus.success,
          articles: _articles,
        ));
      }
    } catch (_) {
      Logger.e(_.runtimeType.toString());
      emit(state.copyWith(status: ArticlesStatus.failure, articles: []));
    }
  }

  Future<void> _saveArticlesLocally(
      ArticlesSaveLocally event, Emitter<ArticlesState> emit) async {
    try {
      await preferencesProvider.saveArticles(event.articles);
    } catch (e) {
      Logger.e(e.toString());
      rethrow;
    }
  }

  Future<void> _giveArticlesLocally(
      ArticlesLoadLocally event, Emitter<ArticlesState> emit) async {
    try {
      emit(state.copyWith(status: ArticlesStatus.initial));
      final loaded = await preferencesProvider.getArticles();
      if (loaded?.isNotEmpty ?? false) {
        _articles = loaded!;
        emit(state.copyWith(
          status: ArticlesStatus.success,
          articles: _articles,
        ));
      } else {
        emit(state.copyWith(
          status: ArticlesStatus.failure,
        ));
      }
    } catch (e) {
      Logger.e(e.toString());
      rethrow;
    }
  }
}
