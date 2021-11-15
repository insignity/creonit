import 'package:creonit/core/error/failure.dart';
import 'package:creonit/core/usecases/usecase_params.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetProductsByCategory extends UseCaseParams<List<ProductEntity>,  ProductParams>{
 
  final ProductRepository productRepository;

  GetProductsByCategory(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(ProductParams params) async {
    print('usecase');
    return await productRepository.getProductsByCategory(params.categoryId, params.page);
  }
}

class ProductParams extends Equatable{
  final int categoryId;
  final int page;

  const ProductParams({required this.categoryId, required this.page});

  @override
  List<Object?> get props => [categoryId];
}