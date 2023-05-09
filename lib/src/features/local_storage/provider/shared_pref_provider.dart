import 'dart:convert';

import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/local_storage/service/shared_pref_service.dart';
import 'package:surf_logger/surf_logger.dart';

abstract class ISharedPreferencesProvider {
  Future<void> saveArticles(List<Article> articles);

  Future<List<Article>?> getArticles();
}

class SharedPreferencesProvider implements ISharedPreferencesProvider {
  final SharedPreferencesService sharedPreferencesService;

  SharedPreferencesProvider({required this.sharedPreferencesService});

  @override
  Future<void> saveArticles(List<Article> articles) async {
    try {
      String json =
          jsonEncode(articles.map((article) => article.toJson()).toList())
              .toString();
      Logger.d('Encoded json: $json');
      await sharedPreferencesService.saveArticles(json);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Article>?> getArticles() async {
    try {
      String data = await sharedPreferencesService.getArticles() ?? '';
      Logger.d('Loaded json: $data');
      return (jsonDecode(data) as List<dynamic>)
          .map((e) => Article.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
