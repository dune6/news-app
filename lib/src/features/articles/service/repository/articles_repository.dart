import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/network/service/api_service.dart';
import 'package:surf_logger/surf_logger.dart';

/// Repository interface for working with articles.
abstract class IArticlesRepository {
  Future<List<Article>> getArticles(Section section);
}

/// Repository for working with a user articles by using [ApiService].
class ArticlesRepository implements IArticlesRepository {
  final ApiService apiService;

  ArticlesRepository({required this.apiService});

  @override
  Future<List<Article>> getArticles(Section section) async {
    try {
      return await apiService.getTList(section.section).then(
          (Map<String, dynamic> list) =>
              list.values.map((e) => Article.fromJson(e)).toList());
    } catch (e) {
      Logger.e(e.toString());
      rethrow;
    }
  }
}

enum Section {
  arts,
  automobiles,
  books,
  business,
  fashion,
  food,
  health,
  home,
  insider,
  magazine,
  movies,
  nyregion,
  obituaries,
  opinion,
  politics,
  realestate,
  science,
  sports,
  sundayreview,
  technology,
  theater,
  tmagazine,
  travel,
  upshot,
  us,
  world,
}

extension SectionExtension on Section {
  String get section {
    switch (this) {
      case Section.arts:
        return 'arts';
      case Section.automobiles:
        return 'automobiles';
      case Section.books:
        return 'books';
      case Section.business:
        return 'business';
      case Section.fashion:
        return 'fashion';
      case Section.food:
        return 'food';
      case Section.health:
        return 'health';
      case Section.home:
        return 'home';
      case Section.insider:
        return 'insider';
      case Section.magazine:
        return 'magazine';
      case Section.movies:
        return 'movies';
      case Section.nyregion:
        return 'nyregion';
      case Section.obituaries:
        return 'obituaries';
      case Section.opinion:
        return 'opinion';
      case Section.politics:
        return 'politics';
      case Section.realestate:
        return 'realestate';
      case Section.science:
        return 'science';
      case Section.sports:
        return 'sports';
      case Section.sundayreview:
        return 'sundayreview';
      case Section.technology:
        return 'technology';
      case Section.theater:
        return 'theater';
      case Section.tmagazine:
        return 't-magazine';
      case Section.travel:
        return 'travel';
      case Section.upshot:
        return 'upshot';
      case Section.us:
        return 'us';
      case Section.world:
        return 'world';
      default:
        throw Exception('Unsupported section');
    }
  }
}
