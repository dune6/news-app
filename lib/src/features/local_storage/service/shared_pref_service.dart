import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_logger/surf_logger.dart';

abstract class ISharedPreferencesService {
  static const String keyArticles = 'articles';

  Future<void> saveArticles(String articlesList);

  Future<String?> getArticles();
}

class SharedPreferencesService implements ISharedPreferencesService {
  @override
  Future<void> saveArticles(String articlesJson) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          ISharedPreferencesService.keyArticles, articlesJson);
      Logger.d('Articles has been saved');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> getArticles() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(ISharedPreferencesService.keyArticles);
    } catch (e) {
      rethrow;
    }
  }
}
