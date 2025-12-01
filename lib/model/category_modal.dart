import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class CategoryModel extends IdentifierModel {
  final String name;

  const CategoryModel({int id = 0, this.name = ''}) : super(id: id);

  factory CategoryModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return CategoryModel(
      id: Model.parseInt(data['id']),
      name: Model.parseString(data['name']),
    );
  }

  factory CategoryModel.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return CategoryModel.fromJson(decoded);
    }
    return CategoryModel.initial();
  }

  static List<CategoryModel> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => CategoryModel.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  CategoryModel copyWith({int? id, String? name}) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  static CategoryModel initial() => const CategoryModel();

  static List<CategoryModel>? _dummyList;

  static Future<List<CategoryModel>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/category.json');
  }
}
