import 'package:flowkit/controller/my_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ControllerBuilder<T extends MyController> extends StatelessWidget {
  final T controller;
  final Widget Function(T controller) builder;
  final String? tag;

  const ControllerBuilder({
    super.key,
    required T init,
    required this.builder,
    this.tag,
  }) : controller = init;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, int>(
      bloc: controller,
      builder: (context, _) => builder(controller),
    );
  }
}