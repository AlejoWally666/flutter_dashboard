import 'dart:convert';
import 'dart:ui';

import 'package:flowkit/helpers/extensions/string.dart';
import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class ShoppingProduct extends IdentifierModel {
  final String name;
  final String image;
  final String description;
  final double price;
  final double rating;
  final int review;
  final int quantity;
  final Color color;
  final bool favorite;

  const ShoppingProduct({
    int id = 0,
    this.name = '',
    this.image = '',
    this.description = '',
    this.price = 0,
    this.rating = 0,
    this.review = 0,
    this.quantity = 0,
    this.color = const Color(0xFFFFFFFF),
    this.favorite = false,
  }) : super(id: id);

  factory ShoppingProduct.fromJson(Map<String, dynamic>? json,
      {int fallbackId = 0}) {
    final data = json ?? <String, dynamic>{};
    return ShoppingProduct(
      id: Model.parseInt(data['id'], defaultValue: fallbackId),
      name: Model.parseString(data['name']),
      image: Model.parseString(data['image']),
      description: Model.parseString(data['description']),
      price: Model.parseDouble(data['price']),
      rating: Model.parseDouble(data['rating']),
      review: Model.parseInt(data['review']),
      quantity: Model.parseInt(data['quantity']),
      color: Model
          .parseString(data['color'], defaultValue: '#FFFFFFFF')
          .toColor,
      favorite: Model.parseBool(data['favorite']),
    );
  }

  factory ShoppingProduct.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ShoppingProduct.fromJson(decoded);
    }
    return ShoppingProduct.initial();
  }

  static List<ShoppingProduct> listFromJson(List<dynamic>? list) {
    final items = list ?? <dynamic>[];
    return List.generate(
      items.length,
      (index) => ShoppingProduct.fromJson(
        items[index] as Map<String, dynamic>?,
        fallbackId: index + 1,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'rating': rating,
        'review': review,
        'quantity': quantity,
        'color': '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
        'favorite': favorite,
      };

  ShoppingProduct copyWith({
    int? id,
    String? name,
    String? image,
    String? description,
    double? price,
    double? rating,
    int? review,
    int? quantity,
    Color? color,
    bool? favorite,
  }) {
    return ShoppingProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      quantity: quantity ?? this.quantity,
      color: color ?? this.color,
      favorite: favorite ?? this.favorite,
    );
  }

  static ShoppingProduct initial() => const ShoppingProduct();

  static List<ShoppingProduct>? _dummyList;

  static Future<List<ShoppingProduct>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/shopping_product.json');
  }
}
