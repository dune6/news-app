import 'package:news_app/src/features/articles/di/articles_di_container.dart';

class AppDiContainer {
  final ArticlesDiContainer articlesDiContainer = ArticlesDiContainer();

  getArticlesRepository() => articlesDiContainer.articlesRepository();
}
