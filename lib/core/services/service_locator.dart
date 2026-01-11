import 'package:flowkit/core/services/i_service.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  ServiceLocator._();

  static final GetIt instance = GetIt.instance;

  static T ensure<T extends IService>(T Function() create) {
    if (!instance.isRegistered<T>()) {
      instance.registerLazySingleton<T>(create);
    }
    final service = instance<T>();
    service.onInit();
    return service;
  }

  static Future<void> reset() => instance.reset();
}
