import 'dart:convert';

import 'package:creonit/core/error/exception.dart';
import 'package:creonit/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  /// Calls the https://vue-study.skillbox.cc/api/productCategories endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getProductsByCategory(int categoryId, int page);
  Future<List<ProductModel>> getAllProducts(int page);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});
 @override
  Future<List<ProductModel>> getAllProducts(int page) async => _getProductsFromUrl(
      "https://vue-study.skillbox.cc/api/products?page=$page&limit=4");
  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId, int page) async => _getProductsFromUrl(
      "https://vue-study.skillbox.cc/api/products?page=$page&categoryId=$categoryId&limit=4");


  Future<List<ProductModel>> _getProductsFromUrl(String url) async {
    print(url);
    final response = await http
        .get(Uri.parse(url), headers: {'accept': 'application/json'});
    if (response.statusCode == 200) {
      final category = json.decode(response.body);
      return (category['items'] as List)
          .map((category) => ProductModel.fromJson(category))
          .toList();
    } else {
      throw ServerException();
    }
  }

}
