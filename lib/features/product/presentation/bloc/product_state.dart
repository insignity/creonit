part of 'product_bloc.dart';
abstract class CategoryState extends Equatable{}

class CategoryEmpty extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {
  final bool isFirstPage;

  CategoryLoading( {this.isFirstPage = false});
  @override
  List<Object?> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  CategoryLoaded({required this.categories});
  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError({required this.message});

  @override
  List<Object?> get props => [message];
  
}
