import 'package:creonit/features/product/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({required id, required title, required slug, required image, required price})
      : super(id: id, title: title, slug: slug, image: image, price: price);
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'], 
        title: json['title'], 
        slug: json['slug']
       , image: json['image']['file']['url'], 
        price: json['price'], 
        );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'image': image,
      'price': price,
    };
  }
}
