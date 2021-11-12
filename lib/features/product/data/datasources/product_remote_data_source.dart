import 'dart:convert';

import 'package:creonit/core/error/exception.dart';
import 'package:creonit/features/product/data/models/category_model.dart';
import 'package:creonit/features/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDataSource {
  /// Calls the https://vue-study.skillbox.cc/api/productCategories endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductModel>> getProductsByCategory(int categoryId);
  Future<List<ProductModel>> getAllProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});
 @override
  Future<List<ProductModel>> getAllProducts() async => _getProductsFromUrl(
      "https://vue-study.skillbox.cc/api/products");
  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async => _getProductsFromUrl(
      "https://vue-study.skillbox.cc/api/products?categoryId=$categoryId");


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
