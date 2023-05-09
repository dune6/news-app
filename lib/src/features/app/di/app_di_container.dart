import 'package:news_app/src/features/articles/di/articles_di_container.dart';
import 'package:news_app/src/features/local_storage/di/local_storage_di_container.dart';

class AppDiContainer {
  final ArticlesDiContainer articlesDiContainer = ArticlesDiContainer();
  final LocalStorageDiContainer localStorageDiContainer =
      LocalStorageDiContainer();

  getArticlesRepository() => articlesDiContainer.articlesRepository();

  getLocalStorageRepository() => localStorageDiContainer.preferencesProvider();
}
