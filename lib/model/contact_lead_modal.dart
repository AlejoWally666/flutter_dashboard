import 'dart:convert';

import 'package:flowkit/images.dart';
import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class ContactLeadModal extends IdentifierModel {
  final String contactName;
  final String number;
  final int leadsScore;
  final String location;
  final DateTime createdAt;
  final String image;

  ContactLeadModal({
    int id = 0,
    this.contactName = '',
    this.number = '',
    this.leadsScore = 0,
    this.location = '',
    DateTime? createdAt,
    this.image = '',
  })  : createdAt = createdAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        super(id: id);

  factory ContactLeadModal.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return ContactLeadModal(
      id: Model.parseInt(data['id']),
      contactName: Model.parseString(data['contact_name']),
      number: Model.parseString(data['number']),
      leadsScore: Model.parseInt(data['leads_score']),
      location: Model.parseString(data['location']),
      createdAt: Model.parseDateTime(data['created_at']),
      image: Model.parseString(
        data['image'],
        defaultValue: Images.randomImage(Images.avatars),
      ),
    );
  }

  factory ContactLeadModal.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ContactLeadModal.fromJson(decoded);
    }
    return ContactLeadModal.initial();
  }

  static List<ContactLeadModal> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => ContactLeadModal.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'contact_name': contactName,
        'number': number,
        'leads_score': leadsScore,
        'location': location,
        'created_at': createdAt.toUtc().toIso8601String(),
        'image': image,
      };

  ContactLeadModal copyWith({
    int? id,
    String? contactName,
    String? number,
    int? leadsScore,
    String? location,
    DateTime? createdAt,
    String? image,
  }) {
    return ContactLeadModal(
      id: id ?? this.id,
      contactName: contactName ?? this.contactName,
      number: number ?? this.number,
      leadsScore: leadsScore ?? this.leadsScore,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      image: image ?? this.image,
    );
  }

  static ContactLeadModal initial() => ContactLeadModal();

  static List<ContactLeadModal>? _dummyList;

  static Future<List<ContactLeadModal>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/contact_leads.json');
  }
}
