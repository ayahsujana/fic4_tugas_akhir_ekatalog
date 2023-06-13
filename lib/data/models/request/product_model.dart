// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// {{
//   "title": "New Product",
//   "price": 100,
//   "description": "A description",
//   "categoryId": 1,
//   "images": [
//     "https://placeimg.com/640/480/any"
//   ]
// }

const String tableProduct = 'product';

class ProductFields {
  static final List<String> value = [
    id,
    title,
    price,
    description,
    categoryId,
    images
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String price = 'price';
  static const String description = 'description';
  static const String categoryId = 'categoryId';
  static const String images = 'images';
}

class ProductModel {
  int? id;
  final String title;
  final int price;
  final String description;
  final int categoryId;
  final List<String> images;
  ProductModel({
    this.id,
    required this.title,
    required this.price,
    required this.description,
    this.categoryId = 1,
    this.images = const ['https://placeimg.com/640/480/any'],
  });

  Map<String, dynamic> toMap() {
    return {
      ProductFields.id: id,
      ProductFields.title: title,
      ProductFields.price: price,
      ProductFields.description: description,
      ProductFields.categoryId: categoryId,
      ProductFields.images: images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map[ProductFields.id]?.toInt() ?? 0,
      title: map[ProductFields.title] ?? '',
      price: map[ProductFields.price]?.toInt() ?? 0,
      description: map[ProductFields.description] ?? '',
      categoryId: map[ProductFields.categoryId]?.toInt() ?? 0,
      images: List<String>.from(map[ProductFields.images]),
    );
  }

factory ProductModel.fromJson(Map<String, dynamic> map) {
    return ProductModel(
      id: map[ProductFields.id]?.toInt() ?? 0,
      title: map[ProductFields.title] ?? '',
      price: map[ProductFields.price]?.toInt() ?? 0,
      description: map[ProductFields.description] ?? '',
      categoryId: map[ProductFields.categoryId]?.toInt() ?? 0,
    );
  }
  

  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    int? id,
    String? title,
    int? price,
    String? description,
    int? categoryId,
    List<String>? images,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      images: images ?? this.images,
    );
  }
}
