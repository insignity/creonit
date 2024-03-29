part of 'product_bloc.dart';
abstract class ProductState extends Equatable{}

class ProductEmpty extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  final bool isFirstPage;
  final List<ProductEntity> oldProductsList;

  ProductLoading(this.oldProductsList, {this.isFirstPage = false});
  
  @override
  List<Object?> get props => [oldProductsList];
}

class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  ProductLoaded({required this.products});
  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  ProductError({required this.message});

  @override
  List<Object?> get props => [message];
  
}
