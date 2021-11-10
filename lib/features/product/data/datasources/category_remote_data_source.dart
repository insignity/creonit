import 'dart:convert';

import 'package:creonit/core/error/exception.dart';
import 'package:creonit/features/product/data/models/category_model.dart';
import 'package:http/http.dart' as http;

abstract class CategoryRemoteDataSource {
  /// Calls the https://vue-study.skillbox.cc/api/productCategories endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategories() async => _getCategoriesFromUrl(
      "https://vue-study.skillbox.cc/api/productCategories");


  Future<List<CategoryModel>> _getCategoriesFromUrl(String url) async {
    print(url);
    final response = await http
        .get(Uri.parse(url), headers: {'accept': 'application/json'});
    if (response.statusCode == 200) {
      final category = json.decode(response.body);
      return (category['items'] as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
