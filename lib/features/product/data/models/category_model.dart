import 'package:creonit/features/product/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({required id, required title, required slug})
      : super(id: id, title: title, slug: slug);
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'], title: json['title'], slug: json['slug']);
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'slug': slug,
    };
  }
}
