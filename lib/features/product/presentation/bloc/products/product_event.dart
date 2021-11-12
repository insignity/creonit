part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}

class ProductEventLoadByCategory extends ProductEvent {
  final int categoryid;
  @override
  List<Object?> get props => [categoryid];
  const ProductEventLoadByCategory({required this.categoryid});
}

class ProductEventLoadAll extends ProductEvent {
  @override
  List<Object?> get props => [];
  const ProductEventLoadAll();
}
