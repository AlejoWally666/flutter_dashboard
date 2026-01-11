import 'dart:convert';
import 'dart:ui';

import 'package:flowkit/helpers/extensions/string.dart';
import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flowkit/model/shopping_product_data.dart';
import 'package:flutter/services.dart';

class ShoppingCart extends IdentifierModel {
  final ShoppingProduct product;
  final String selectedSize;
  final int quantity;
  final Color selectedColor;

  const ShoppingCart({
    int id = 0,
    this.product = const ShoppingProduct(),
    this.selectedSize = '',
    this.quantity = 0,
    this.selectedColor = const Color(0xFFFFFFFF),
  }) : super(id: id);

  factory ShoppingCart.fromJson(Map<String, dynamic>? json, {int fallbackId = 0}) {
    final data = json ?? <String, dynamic>{};
    return ShoppingCart(
      id: Model.parseInt(data['id'], defaultValue: fallbackId),
      product: ShoppingProduct.fromJson(
        data['product'] as Map<String, dynamic>?,
        fallbackId: fallbackId,
      ),
      selectedSize: Model.parseString(data['selectedSize']),
      quantity: Model.parseInt(data['quantity'], defaultValue: 1),
      selectedColor: Model
          .parseString(data['selectedColor'], defaultValue: '#FFFFFFFF')
          .toColor,
    );
  }

  factory ShoppingCart.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ShoppingCart.fromJson(decoded);
    }
    return ShoppingCart.initial();
  }

  static List<ShoppingCart> listFromJson(List<dynamic>? list) {
    final items = list ?? <dynamic>[];
    return List.generate(
      items.length,
      (index) => ShoppingCart.fromJson(
        items[index] as Map<String, dynamic>?,
        fallbackId: index + 1,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'product': product.toJson(),
        'selectedSize': selectedSize,
        'quantity': quantity,
        'selectedColor': '#${selectedColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
      };

  ShoppingCart copyWith({
    int? id,
    ShoppingProduct? product,
    String? selectedSize,
    int? quantity,
    Color? selectedColor,
  }) {
    return ShoppingCart(
      id: id ?? this.id,
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  static ShoppingCart initial() => const ShoppingCart();

  static List<ShoppingCart>? _dummyList;

  static Future<List<ShoppingCart>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/shopping_cart.json');
  }
}
