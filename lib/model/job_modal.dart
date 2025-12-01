import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class JobModal extends IdentifierModel {
  final String jobTitle;
  final String jobLocation;
  final int jobHr;
  final int price;
  final List<String> jobWork;

  const JobModal({
    int id = 0,
    this.jobTitle = '',
    this.jobLocation = '',
    this.jobHr = 0,
    this.price = 0,
    this.jobWork = const [],
  }) : super(id: id);

  factory JobModal.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return JobModal(
      id: Model.parseInt(data['id']),
      jobTitle: Model.parseString(data['job_title']),
      jobLocation: Model.parseString(data['job_location']),
      jobHr: Model.parseInt(data['job_hr']),
      price: Model.parseInt(data['price']),
      jobWork: Model.parseList<String>(data['job_work'], (item) => Model.parseString(item)),
    );
  }

  factory JobModal.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return JobModal.fromJson(decoded);
    }
    return JobModal.initial();
  }

  static List<JobModal> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => JobModal.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'job_title': jobTitle,
        'job_location': jobLocation,
        'job_hr': jobHr,
        'price': price,
        'job_work': jobWork,
      };

  JobModal copyWith({
    int? id,
    String? jobTitle,
    String? jobLocation,
    int? jobHr,
    int? price,
    List<String>? jobWork,
  }) {
    return JobModal(
      id: id ?? this.id,
      jobTitle: jobTitle ?? this.jobTitle,
      jobLocation: jobLocation ?? this.jobLocation,
      jobHr: jobHr ?? this.jobHr,
      price: price ?? this.price,
      jobWork: jobWork ?? this.jobWork,
    );
  }

  static JobModal initial() => const JobModal();

  static List<JobModal>? _dummyList;

  static Future<List<JobModal>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/job.json');
  }
}
