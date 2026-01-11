import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class Food extends IdentifierModel {
  final String image;
  final String foodName;
  final String customerName;
  final String address;
  final double price;
  final bool pending;

  const Food({
    int id = 0,
    this.image = '',
    this.foodName = '',
    this.customerName = '',
    this.address = '',
    this.price = 0,
    this.pending = false,
  }) : super(id: id);

  factory Food.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return Food(
      id: Model.parseInt(data['id']),
      image: Model.parseString(data['image']),
      foodName: Model.parseString(data['food_name']),
      customerName: Model.parseString(data['customer_name']),
      address: Model.parseString(data['address']),
      price: Model.parseDouble(data['price']),
      pending: Model.parseBool(data['isPending']),
    );
  }

  factory Food.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return Food.fromJson(decoded);
    }
    return Food.initial();
  }

  static List<Food> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => Food.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'food_name': foodName,
        'customer_name': customerName,
        'address': address,
        'price': price,
        'isPending': pending,
      };

  Food copyWith({
    int? id,
    String? image,
    String? foodName,
    String? customerName,
    String? address,
    double? price,
    bool? pending,
  }) {
    return Food(
      id: id ?? this.id,
      image: image ?? this.image,
      foodName: foodName ?? this.foodName,
      customerName: customerName ?? this.customerName,
      address: address ?? this.address,
      price: price ?? this.price,
      pending: pending ?? this.pending,
    );
  }

  static Food initial() => const Food();

  static List<Food>? _dummyList;

  static Future<List<Food>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/food_data.json');
  }
}
