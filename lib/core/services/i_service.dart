import 'package:meta/meta.dart';

/// Base contract for injectable services used across the app.
abstract class IService {
  /// Hook called after the service is created. Override to prepare data.
  @mustCallSuper
  void onInit() {}

  /// Disposes any resources held by the service.
  Future<void> dispose();
}
