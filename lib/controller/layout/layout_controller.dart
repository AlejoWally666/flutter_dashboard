import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/helpers/theme/theme_customizer.dart';
import 'package:flutter/material.dart';

class LayoutController extends MyController {
  ThemeCustomizer themeCustomizer = ThemeCustomizer();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> scrollKey = GlobalKey();

  ScrollController scrollController = ScrollController();

  bool isLastIndex = false;

  @override
  void onInit() {
    ThemeCustomizer.addListener(onChangeTheme);
    super.onInit();
  }

  void onChangeTheme(ThemeCustomizer oldVal, ThemeCustomizer newVal) {
    themeCustomizer = newVal;
    update();

    if (newVal.rightBarOpen) {
      scaffoldKey.currentState?.openEndDrawer();
    } else {
      scaffoldKey.currentState?.closeEndDrawer();
    }
  }

  void enableNotificationShade() {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  void disableNotificationShade() {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  Future<void> dispose() async {
    ThemeCustomizer.removeListener(onChangeTheme);
    scrollController.dispose();
    await super.dispose();
  }
}
