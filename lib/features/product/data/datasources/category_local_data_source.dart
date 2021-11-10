import 'dart:convert';

import 'package:creonit/features/product/data/models/category_model.dart';
import 'package:creonit/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedCategoriesList = 'CACHED_CATEGORIES_LIST';

abstract class CategoryLocalDataSource {
  /// Get the cached [List<PersonModel>] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.

  Future<List<CategoryModel>> getCategoriesFromCache();
  Future categoriesToCache(List<CategoryModel> categories);
}


class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getCategoriesFromCache() {
    final jsonCategoriesList = sharedPreferences.getStringList(cachedCategoriesList);
    if (jsonCategoriesList!.isNotEmpty) {
      return Future.value(jsonCategoriesList
          .map((category) => CategoryModel.fromJson(json.decode(category)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future categoriesToCache(List<CategoryModel> categories) {
    final List<String> jsonCategoriesList =
        categories.map((category) => json.encode(category.toJson())).toList();

    sharedPreferences.setStringList(cachedCategoriesList, jsonCategoriesList);
    print('Categories to write Cache: ${jsonCategoriesList.length}');
    return Future.value(jsonCategoriesList);
  }
}
