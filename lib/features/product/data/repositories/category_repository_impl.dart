import 'package:creonit/core/error/exception.dart';
import 'package:creonit/core/platform/network_info.dart';
import 'package:creonit/features/product/data/datasources/category_local_data_source.dart';
import 'package:creonit/features/product/data/datasources/category_remote_data_source.dart';
import 'package:creonit/features/product/data/models/category_model.dart';
import 'package:creonit/features/product/domain/entities/category_entity.dart';
import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    return _getCategorys(() {
      return remoteDataSource.getAllCategories();
    });
  }

  Future<Either<Failure, List<CategoryEntity>>> _getCategorys(
      Future<List<CategoryModel>> Function() getCategorys) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategory = await getCategorys();
        localDataSource.categoriesToCache(remoteCategory);
        return Right(remoteCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locationCategory = await localDataSource.getCategoriesFromCache();
        return Right(locationCategory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
