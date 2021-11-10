import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository{
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
}