import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/entities/product_entity.dart';
import 'package:creonit/features/product/domain/usecases/get_all_products.dart';
import 'package:creonit/features/product/domain/usecases/get_products_by_category.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'product_event.dart';
part 'product_state.dart';

const serverFailureMessage = 'Server Failure';
const cacheFailureMessage = 'Cache Failure';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  GetProductsByCategory getProductsByCategory;
  GetAllProducts getAllProducts;
  ProductBloc(
      {required this.getProductsByCategory, required this.getAllProducts})
      : super(ProductEmpty());

  int categoryId = 0;
  List<int> page = List.generate(20, (index) => 1);
  List<List<ProductEntity>> oldProducts = List.generate(20, (index) => []);

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductEventLoadByCategory) {
      categoryId = event.categoryid;
      print(oldProducts[categoryId]);
      yield* _mapFetchProductsToState();
    } else if (event is ProductEventLoadAll) {
      categoryId = 0;
      yield* _mapFetchProductsToState();
    }
  }

  Stream<ProductState> _mapFetchProductsToState() async* {
    if (state is ProductLoading) return;
    yield ProductLoading(oldProducts[categoryId],
        isFirstPage: page[categoryId] == 1);
    final failureOrProduct = (categoryId == 0)
        ? await getAllProducts(ProductPage(page: page[categoryId]))
        : await getProductsByCategory(
            ProductParams(categoryId: categoryId, page: page[categoryId]));

    yield failureOrProduct
        .fold((error) => ProductError(message: _mapFailureToMessage(error)),
            (product) {
      final products = (state as ProductLoading).oldProductsList;
      for (var item in product) {
        var check = products.any((element) => element == item);
        if (check == true) {
          continue;
        } else {
          products.add(item);
        }
      }
      oldProducts[categoryId] = products;
      page[categoryId]++;
      categoryId = 0;

      return ProductLoaded(products: products);
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
