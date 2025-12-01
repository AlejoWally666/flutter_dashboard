import 'dart:convert';

import 'package:flowkit/model/identifier_model.dart';
import 'package:flowkit/model/model.dart';

class User extends IdentifierModel {
  final String email;
  final String firstName;
  final String lastName;

  const User({int id = 0, this.email = '', this.firstName = '', this.lastName = ''})
      : super(id: id);

  String get name => "$firstName $lastName".trim();

  factory User.fromJson(Map<String, dynamic>? json) {
    final data = json ?? <String, dynamic>{};
    return User(
      id: Model.parseInt(data['id']),
      email: Model.parseString(data['email']),
      firstName: Model.parseString(data['first_name']),
      lastName: Model.parseString(data['last_name']),
    );
  }

  factory User.fromText(String source) {
    final dynamic decoded = jsonDecode(source);
    if (decoded is Map<String, dynamic>) {
      return User.fromJson(decoded);
    }
    return User.initial();
  }

  static List<User> listFromJson(List<dynamic>? list) {
    return Model.parseList(list, (item) => User.fromJson(item));
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
      };

  User copyWith({int? id, String? email, String? firstName, String? lastName}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  static User initial() => const User();
}
