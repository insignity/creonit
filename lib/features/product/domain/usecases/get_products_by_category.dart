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
  Future<Either<Failure, List<ProductEntity>>> call(ProductParams productParams) async {
    print('usecase');
    return await productRepository.getProductsByCategory(productParams.categoryId);
  }
}

class ProductParams extends Equatable{
  final int categoryId;

  const ProductParams({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}