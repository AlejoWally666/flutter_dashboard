import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

enum VisitorChannel {
  organicSearch('Organic Search'),
  direct('Direct'),
  referral('Referral'),
  social('Social'),
  email('Email'),
  paidSearch('Paid Search'),
  other('Other');

  const VisitorChannel(this.label);
  final String label;

  static VisitorChannel fromLabel(String value) {
    return VisitorChannel.values.firstWhere(
      (channel) => channel.label.toLowerCase() == value.toLowerCase(),
      orElse: () => VisitorChannel.other,
    );
  }
}

class VisitorByChannelsModel extends IdentifierModel {
  final VisitorChannel channel;
  final int session;
  final int targetReached;
  final double bounceRate;
  final double pagePerSession;
  final DateTime sessionDuration;

  const VisitorByChannelsModel({
    int id = 0,
    this.channel = VisitorChannel.other,
    this.session = 0,
    this.targetReached = 0,
    this.bounceRate = 0,
    this.pagePerSession = 0,
    this.sessionDuration = const DateTime.fromMillisecondsSinceEpoch(0),
  }) : super(id: id);

  factory VisitorByChannelsModel.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return VisitorByChannelsModel(
      id: Model.parseInt(data['id']),
      channel: VisitorChannel.fromLabel(Model.parseString(data['channel'])),
      session: Model.parseInt(data['session']),
      targetReached: Model.parseInt(data['target_reached']),
      bounceRate: Model.parseDouble(data['bounce_rate']),
      pagePerSession: Model.parseDouble(data['page_per_session']),
      sessionDuration: Model.parseDateTime(data['session_duration']),
    );
  }

  factory VisitorByChannelsModel.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return VisitorByChannelsModel.fromJson(decoded);
    }
    return VisitorByChannelsModel.initial();
  }

  static List<VisitorByChannelsModel> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => VisitorByChannelsModel.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'channel': channel.label,
        'session': session,
        'target_reached': targetReached,
        'bounce_rate': bounceRate,
        'page_per_session': pagePerSession,
        'session_duration': sessionDuration.toUtc().toIso8601String(),
      };

  VisitorByChannelsModel copyWith({
    int? id,
    VisitorChannel? channel,
    int? session,
    int? targetReached,
    double? bounceRate,
    double? pagePerSession,
    DateTime? sessionDuration,
  }) {
    return VisitorByChannelsModel(
      id: id ?? this.id,
      channel: channel ?? this.channel,
      session: session ?? this.session,
      targetReached: targetReached ?? this.targetReached,
      bounceRate: bounceRate ?? this.bounceRate,
      pagePerSession: pagePerSession ?? this.pagePerSession,
      sessionDuration: sessionDuration ?? this.sessionDuration,
    );
  }

  static VisitorByChannelsModel initial() => const VisitorByChannelsModel();

  static List<VisitorByChannelsModel>? _dummyList;

  static Future<List<VisitorByChannelsModel>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/visitors_by_channels_data.json');
  }
}
