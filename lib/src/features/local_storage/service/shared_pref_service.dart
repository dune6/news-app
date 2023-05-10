import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_logger/surf_logger.dart';

abstract class ISharedPreferencesService {
  static const String keyArticles = 'articles';
  static const String keyCategories = 'categories';

  Future<void> saveArticles(String articlesList);

  Future<String?> getArticles();

  Future<void> saveCategories(List<String> categories);

  Future<List<String>?> getCategories();
}

/// Service for save and get values for local db based on [SharedPreferences]
class SharedPreferencesService implements ISharedPreferencesService {
  @override
  // save current categories
  Future<void> saveCategories(List<String> categories) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          ISharedPreferencesService.keyCategories, categories);
      Logger.d('Categories has been saved');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>?> getCategories() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(ISharedPreferencesService.keyCategories);
    } catch (e) {
      rethrow;
    }
  }

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
