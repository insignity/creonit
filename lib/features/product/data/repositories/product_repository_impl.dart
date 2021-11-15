import 'package:creonit/core/error/exception.dart';
import 'package:creonit/core/platform/network_info.dart';
import 'package:creonit/features/product/data/datasources/product_remote_data_source.dart';
import 'package:creonit/features/product/data/models/product_model.dart';
import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(
      {required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
      int categoryId, int page) async {
    return _getProducts(() {
      return remoteDataSource.getProductsByCategory(categoryId, page);
    });
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(int page) async {
    return _getProducts(() {
      return remoteDataSource.getAllProducts(page);
    });
  }

  Future<Either<Failure, List<ProductEntity>>> _getProducts(
      Future<List<ProductModel>> Function() getCategorys) async {
    try {
      final remoteCategory = await getCategorys();
      return Right(remoteCategory);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
