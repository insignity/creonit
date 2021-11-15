import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository{
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(int categoryId, int page);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(int page);
}