import 'dart:convert';

import 'package:flowkit/images.dart';
import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class PopularCandidateModal extends IdentifierModel {
  final String name;
  final String userId;
  final String image;
  final String position;
  final String experience;
  final String salary;

  const PopularCandidateModal({
    int id = 0,
    this.name = '',
    this.userId = '',
    this.image = '',
    this.position = '',
    this.experience = '',
    this.salary = '',
  }) : super(id: id);

  factory PopularCandidateModal.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return PopularCandidateModal(
      id: Model.parseInt(data['id']),
      name: Model.parseString(data['name']),
      userId: Model.parseString(data['userId']),
      image: Model.parseString(
        data['image'],
        defaultValue: Images.randomImage(Images.avatars),
      ),
      position: Model.parseString(data['position']),
      experience: Model.parseString(data['experience']),
      salary: Model.parseString(data['salary']),
    );
  }

  factory PopularCandidateModal.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return PopularCandidateModal.fromJson(decoded);
    }
    return PopularCandidateModal.initial();
  }

  static List<PopularCandidateModal> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => PopularCandidateModal.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'userId': userId,
        'image': image,
        'position': position,
        'experience': experience,
        'salary': salary,
      };

  PopularCandidateModal copyWith({
    int? id,
    String? name,
    String? userId,
    String? image,
    String? position,
    String? experience,
    String? salary,
  }) {
    return PopularCandidateModal(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      image: image ?? this.image,
      position: position ?? this.position,
      experience: experience ?? this.experience,
      salary: salary ?? this.salary,
    );
  }

  static PopularCandidateModal initial() => const PopularCandidateModal();

  static List<PopularCandidateModal>? _dummyList;

  static Future<List<PopularCandidateModal>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/popular_candidate.json');
  }
}
