import 'package:creonit/core/error/failure.dart';
import 'package:creonit/core/usecases/usecase_params.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/domain/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAllProducts extends UseCaseParams<List<ProductEntity>,  ProductPage>{
 
  final ProductRepository productRepository;

  GetAllProducts(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(ProductPage productPage) async {
    return await productRepository.getAllProducts(productPage.page);
  }
}

class ProductPage extends Equatable{
  final int page;

  const ProductPage({required this.page});

  @override
  List<Object?> get props => [page];
}