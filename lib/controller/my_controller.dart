import 'package:flowkit/core/services/i_service.dart';
import 'package:flowkit/helpers/theme/theme_customizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

abstract class MyController extends Cubit<int> implements IService {
  bool _initialized = false;

  MyController() : super(0) {
    onInit();
  }

  @override
  @mustCallSuper
  void onInit() {
    if (_initialized) return;
    _initialized = true;
    ThemeCustomizer.addListener((old, newVal) {
      if (old.theme != newVal.theme ||
          (old.currentLanguage.languageName !=
              newVal.currentLanguage.languageName)) {
        update();
        onThemeChanged();
      }
    });
  }

  @protected
  void update() => emit(state + 1);

  @override
  Future<void> dispose() => close();

  void onThemeChanged() {}
}
