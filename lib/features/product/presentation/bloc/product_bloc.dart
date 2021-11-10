import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:creonit/core/error/failure.dart';
import 'package:creonit/features/product/domain/entities/category_entity.dart';
import 'package:creonit/features/product/domain/usecases/get_all_categories.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'product_event.dart';
part 'product_state.dart';

const serverFailureMessage = 'Server Failure';
const cacheFailureMessage = 'Cache Failure';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  GetAllCategories getAllCategories;
  CategoryBloc({required this.getAllCategories}) : super(CategoryEmpty());

  int page = 1;

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {

    if (event is CategoryLoad) {
      yield* _mapFetchCategoriesToState();
    }
  }

  Stream<CategoryState> _mapFetchCategoriesToState() async* {
    if (state is CategoryLoading) return;
    final currentState = state;

    var oldCategories = <CategoryEntity>[];
    if (currentState is CategoryLoaded) {
      oldCategories = currentState.categories;
    }

    yield CategoryLoading(isFirstPage: page == 1);

    final failureOrPerson = await getAllCategories();

    yield failureOrPerson
        .fold((error) => CategoryError(message: _mapFailureToMessage(error)),
            (category) {
      page++;
      return CategoryLoaded(categories: category);
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
