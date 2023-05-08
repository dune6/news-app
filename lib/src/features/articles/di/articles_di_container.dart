import 'package:news_app/src/features/articles/service/repository/articles_repository.dart';
import 'package:news_app/src/features/network/service/api_service.dart';

class ArticlesDiContainer {
  final ApiService _apiService = ApiService();

  ArticlesRepository articlesRepository() =>
      ArticlesRepository(apiService: _apiService);
}
