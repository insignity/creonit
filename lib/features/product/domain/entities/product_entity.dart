import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String slug;
  final String image;
  final int price;

  const ProductEntity(
      {required this.id,
      required this.title,
      required this.slug,
      required this.image,
      required this.price,
      });

  @override
  List<Object?> get props => [
        id,
        title,
        slug,
      ];
}

