import 'package:flowkit/model/model.dart';

abstract class IdentifierModel extends Model {
  final int id;

  const IdentifierModel({this.id = 0});

  @override
  Map<String, dynamic> toJson() => {'id': id};
}
