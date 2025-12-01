import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class ContactModel extends IdentifierModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String website;
  final String job;
  final String company;
  final String address;
  final double? experience;

  const ContactModel({
    int id = 0,
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.website = '',
    this.job = '',
    this.company = '',
    this.address = '',
    this.experience,
  }) : super(id: id);

  factory ContactModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return ContactModel(
      id: Model.parseInt(data['id']),
      name: Model.parseString(data['name']),
      email: Model.parseString(data['email']),
      phoneNumber: Model.parseString(data['phone_number']),
      website: Model.parseString(data['website']),
      job: Model.parseString(data['job']),
      company: Model.parseString(data['company']),
      address: Model.parseString(data['address']),
      experience: data['experience'] != null
          ? Model.parseDouble(data['experience'])
          : null,
    );
  }

  factory ContactModel.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ContactModel.fromJson(decoded);
    }
    return ContactModel.initial();
  }

  static List<ContactModel> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => ContactModel.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
        'website': website,
        'job': job,
        'company': company,
        'address': address,
        'experience': experience,
      };

  ContactModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? website,
    String? job,
    String? company,
    String? address,
    double? experience,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      website: website ?? this.website,
      job: job ?? this.job,
      company: company ?? this.company,
      address: address ?? this.address,
      experience: experience ?? this.experience,
    );
  }

  static ContactModel initial() => const ContactModel();

  static List<ContactModel>? _dummyList;

  static Future<List<ContactModel>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/contact.json');
  }
}
