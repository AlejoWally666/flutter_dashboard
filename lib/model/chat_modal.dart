import 'dart:convert';

import 'package:flowkit/images.dart';
import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';
import 'package:flutter/services.dart';

class ChatModel extends IdentifierModel {
  final String firstName;
  final String image;
  final String email;
  final List<ChatMessageModel> messages;

  const ChatModel({
    int id = 0,
    this.firstName = '',
    this.image = '',
    this.email = '',
    this.messages = const [],
  }) : super(id: id);

  factory ChatModel.fromJson(Map<String, dynamic>? json, {int fallbackId = 0}) {
    final data = json ?? <String, dynamic>{};
    return ChatModel(
      id: Model.parseInt(data['id'], defaultValue: fallbackId),
      firstName: Model.parseString(data['first_name']),
      email: Model.parseString(data['email']),
      image: Model.parseString(data['image'], defaultValue: Images.randomImage(Images.avatars)),
      messages: ChatMessageModel.listFromJson(data['messages'] as List<dynamic>?),
    );
  }

  factory ChatModel.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ChatModel.fromJson(decoded);
    }
    return ChatModel.initial();
  }

  static List<ChatModel> listFromJson(List<dynamic>? list) {
    final items = list ?? <dynamic>[];
    return List.generate(
      items.length,
      (index) => ChatModel.fromJson(items[index] as Map<String, dynamic>?,
          fallbackId: index + 1),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'image': image,
        'email': email,
        'messages': messages.map((message) => message.toJson()).toList(),
      };

  ChatModel copyWith({
    int? id,
    String? firstName,
    String? image,
    String? email,
    List<ChatMessageModel>? messages,
  }) {
    return ChatModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      image: image ?? this.image,
      email: email ?? this.email,
      messages: messages ?? this.messages,
    );
  }

  static ChatModel initial() => const ChatModel();

  static List<ChatModel>? _dummyList;

  static Future<List<ChatModel>> get dummyList async {
    if (_dummyList == null) {
      final dynamic data = json.decode(await getData());
      _dummyList = listFromJson(data as List<dynamic>?);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return rootBundle.loadString('assets/data/message.json');
  }
}

class ChatMessageModel extends IdentifierModel {
  final String message;
  final String imageSent;
  final DateTime sendAt;
  final bool fromMe;

  ChatMessageModel({
    int id = 0,
    this.message = '',
    this.imageSent = '',
    DateTime? sendAt,
    this.fromMe = false,
  })  : sendAt = sendAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        super(id: id);

  factory ChatMessageModel.fromJson(Map<String, dynamic>? json,
      {int fallbackId = 0}) {
    final data = json ?? <String, dynamic>{};
    return ChatMessageModel(
      id: Model.parseInt(data['id'], defaultValue: fallbackId),
      message: Model.parseString(data['message']),
      imageSent:
          Model.parseString(data['image_sent'], defaultValue: Images.randomImage(Images.avatars)),
      sendAt: Model.parseDateTime(data['send_at']),
      fromMe: Model.parseBool(data['from_me']),
    );
  }

  factory ChatMessageModel.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return ChatMessageModel.fromJson(decoded);
    }
    return ChatMessageModel.initial();
  }

  static List<ChatMessageModel> listFromJson(List<dynamic>? list) {
    final items = list ?? <dynamic>[];
    return List.generate(
      items.length,
      (index) => ChatMessageModel.fromJson(
          items[index] as Map<String, dynamic>?,
          fallbackId: index + 1),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'message': message,
        'image_sent': imageSent,
        'send_at': sendAt.toUtc().toIso8601String(),
        'from_me': fromMe,
      };

  ChatMessageModel copyWith({
    int? id,
    String? message,
    String? imageSent,
    DateTime? sendAt,
    bool? fromMe,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      imageSent: imageSent ?? this.imageSent,
      sendAt: sendAt ?? this.sendAt,
      fromMe: fromMe ?? this.fromMe,
    );
  }

  static ChatMessageModel initial() => ChatMessageModel();
}
