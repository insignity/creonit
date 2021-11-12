part of 'category_bloc.dart';
@immutable
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class CategoryLoad extends CategoryEvent{}