import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/domain/usecases/get_products_by_category.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'product_event.dart';
part 'product_state.dart';

const serverFailureMessage = 'Server Failure';
const cacheFailureMessage = 'Cache Failure';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  GetProductsByCategory getProductsByCategory;
  ProductBloc({required this.getProductsByCategory}) : super(ProductEmpty());

  int page = 1;
  int categoryId = 1;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    print('bloc');
    if (event is ProductEventLoadByCategory) {
      categoryId = event.categoryid;
      yield* _mapFetchCategoriesToState();
    }
  }

  Stream<ProductState> _mapFetchCategoriesToState() async* {
    if (state is ProductLoading) return;
    final currentState = state;
    if (currentState is ProductLoaded) {}

    yield ProductLoading(isFirstPage: page == 1);

    final failureOrProduct = await getProductsByCategory(ProductParams(categoryId: categoryId));

    yield failureOrProduct
        .fold((error) => ProductError(message: _mapFailureToMessage(error)),
            (product) {
      page++;
      return ProductLoaded(products: product);
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
