import 'package:creonit/core/error/failure.dart';
import 'package:creonit/core/usecases/usecase.dart';
import 'package:creonit/features/product/domain/entities/category_entity.dart';
import 'package:creonit/features/product/domain/repositories/category_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCategories extends UseCase<List<CategoryEntity>>{ 
  final CategoryRepository categoryRepository;

  GetAllCategories(this.categoryRepository);

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await categoryRepository.getAllCategories();
  }
}