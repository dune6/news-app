import 'dart:convert';

import 'package:news_app/src/features/articles/domain/article.dart';
import 'package:news_app/src/features/local_storage/service/shared_pref_service.dart';
import 'package:surf_logger/surf_logger.dart';

abstract class ISharedPreferencesProvider {
  Future<void> saveArticles(List<Article> articles);

  Future<List<Article>?> getArticles();

  Future<void> saveCategories(List<String> articles);

  Future<List<String>?> getCategories();
}

/// Repository for communicating service layer [SharedPreferencesService]
class SharedPreferencesProvider implements ISharedPreferencesProvider {
  final SharedPreferencesService sharedPreferencesService;

  SharedPreferencesProvider({required this.sharedPreferencesService});

  // save last 40 downloaded
  @override
  Future<void> saveArticles(List<Article> articles) async {
    try {
      List<Article> articlesToSave = [];
      if (articles.length >= 40) {
        articlesToSave.addAll(articles.sublist(articles.length - 40));
      } else {
        List<Article>? downloaded = await getArticles();
        if (downloaded != null) {
          if (downloaded.length + articles.length <= 40) {
            articlesToSave.addAll(articles.reversed);
            articlesToSave.addAll(downloaded.reversed);
          } else {
            articlesToSave.addAll(articles.reversed);
            articlesToSave.addAll(downloaded
                .sublist(downloaded.length - (40 - articles.length))
                .reversed);
          }
        } else {
          if (articles.length >= 40) {
            articlesToSave
                .addAll(articles.sublist(articles.length - 40).reversed);
          } else {
            articlesToSave.addAll(articles.reversed);
          }
        }
      }

      String json =
          jsonEncode(articlesToSave.map((article) => article.toJson()).toList())
              .toString();
      Logger.d('Encoded json: $json');
      await sharedPreferencesService.saveArticles(json);
    } catch (e) {
      rethrow;
    }
  }

  // get saved locally articles
  @override
  Future<List<Article>?> getArticles() async {
    try {
      String data = await sharedPreferencesService.getArticles() ?? '';
      Logger.d('Loaded json: $data');
      if (data == '') {
        return null;
      } else {
        return (jsonDecode(data) as List<dynamic>)
            .map((e) => Article.fromJson(e))
            .toList();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> getCategories() async {
    try {
      List<String> categories =
          await sharedPreferencesService.getCategories() ?? [];
      Logger.d('Categories: $categories');
      return categories;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveCategories(List<String> articles) async {
    try {
      await sharedPreferencesService.saveCategories(articles);
    } catch (e) {
      rethrow;
    }
  }
}
