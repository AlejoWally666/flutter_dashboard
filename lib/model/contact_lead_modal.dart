import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class ContactLeadModal extends IdentifierModel {
  final String name;
  final String location;
  final String date;
  final double numberOfCalls;
  final double dealValue;

  const ContactLeadModal({
    int id = 0,
    this.name = '',
    this.location = '',
    this.date = '',
    this.numberOfCalls = 0,
    this.dealValue = 0,
  }) : super(id: id);

  factory ContactLeadModal.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return ContactLeadModal(
      id: Model.parseInt(data['id']),
      name: Model.parseString(data['name']),
      location: Model.parseString(data['location']),
      date: Model.parseString(data['date']),
      numberOfCalls: Model.parseDouble(data['number_of_calls']),
      dealValue: Model.parseDouble(data['deal_value']),
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
        'name': name,
        'location': location,
        'date': date,
        'number_of_calls': numberOfCalls,
        'deal_value': dealValue,
      };

  ContactLeadModal copyWith({
    int? id,
    String? name,
    String? location,
    String? date,
    double? numberOfCalls,
    double? dealValue,
  }) {
    return ContactLeadModal(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      date: date ?? this.date,
      numberOfCalls: numberOfCalls ?? this.numberOfCalls,
      dealValue: dealValue ?? this.dealValue,
    );
  }

  static ContactLeadModal initial() => const ContactLeadModal();

  static List<ContactLeadModal>? _dummyList;

  static Future<List<ContactLeadModal>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/contact_lead_data.json');
  }
}
