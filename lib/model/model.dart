import 'dart:convert';

abstract class Model {
  const Model();

  Map<String, dynamic> toJson();

  String stringify() => jsonEncode(toJson());

  static int parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    return int.tryParse(value.toString()) ?? defaultValue;
  }

  static double parseDouble(dynamic value, {double defaultValue = 0}) {
    if (value == null) return defaultValue;
    return double.tryParse(value.toString()) ?? defaultValue;
  }

  static String parseString(dynamic value, {String defaultValue = ''}) {
    return value?.toString() ?? defaultValue;
  }

  static bool parseBool(dynamic value, {bool defaultValue = false}) {
    if (value is bool) return value;
    if (value == null) return defaultValue;
    final normalized = value.toString().toLowerCase();
    if (normalized == 'true' || normalized == '1') return true;
    if (normalized == 'false' || normalized == '0') return false;
    return defaultValue;
  }

  static DateTime parseDateTime(
    dynamic value, {
    DateTime? defaultValue,
  }) {
    final fallback = defaultValue ?? DateTime.fromMillisecondsSinceEpoch(0);
    if (value == null) return fallback;
    return DateTime.tryParse(value.toString()) ?? fallback;
  }

  static List<T> parseList<T>(dynamic value, T Function(dynamic item) mapper) {
    if (value is List) {
      return value.map((element) => mapper(element)).toList();
    }
    return <T>[];
  }
}
