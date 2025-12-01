import 'package:flowkit/helpers/theme/theme_customizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

abstract class MyController extends Cubit<int> {
  MyController() : super(0) {
    onInit();
  }

  @mustCallSuper
  void onInit() {
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

  void onThemeChanged() {}
}
