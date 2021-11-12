import 'package:creonit/core/error/failure.dart';
import 'package:creonit/core/usecases/usecase.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';

class GetProductsByCategory extends UseCase<List<ProductEntity>>{
 
  final ProductRepository productRepository;

  GetProductsByCategory(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await productRepository.getAllProducts();
  }
}
