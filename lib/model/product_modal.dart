import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class ProductModal extends IdentifierModel {
  final String name;
  final String image;
  final int categoryId;
  final int stock;
  final double price;
  final double rating;

  const ProductModal({
    int id = 0,
    this.name = '',
    this.image = '',
    this.categoryId = 0,
    this.stock = 0,
    this.price = 0,
    this.rating = 0,
  }) : super(id: id);

  factory ProductModal.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return ProductModal(
      id: Model.parseInt(data['id']),
      name: Model.parseString(data['name']),
      image: Model.parseString(data['image']),
      categoryId: Model.parseInt(data['category_id']),
      stock: Model.parseInt(data['stock']),
      price: Model.parseDouble(data['price']),
      rating: Model.parseDouble(data['rating']),
    );
  }

  factory ProductModal.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ProductModal.fromJson(decoded);
    }
    return ProductModal.initial();
  }

  static List<ProductModal> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => ProductModal.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'category_id': categoryId,
        'stock': stock,
        'price': price,
        'rating': rating,
      };

  ProductModal copyWith({
    int? id,
    String? name,
    String? image,
    int? categoryId,
    int? stock,
    double? price,
    double? rating,
  }) {
    return ProductModal(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      categoryId: categoryId ?? this.categoryId,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      rating: rating ?? this.rating,
    );
  }

  static ProductModal initial() => const ProductModal();

  static List<ProductModal>? _dummyList;

  static Future<List<ProductModal>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/product.json');
  }
}
