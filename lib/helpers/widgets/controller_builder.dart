import 'package:flowkit/controller/my_controller.dart';
import 'package:flowkit/core/services/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControllerBuilder<T extends MyController> extends StatelessWidget {
  final Widget Function(T controller) builder;
  final String? tag;
  final T Function() _create;

  const ControllerBuilder({
    super.key,
    required T Function() init,
    required this.builder,
    this.tag,
  }) : _create = init;

  @override
  Widget build(BuildContext context) {
    final controller = ServiceLocator.ensure<T>(_create);
    return BlocBuilder<T, int>(
      bloc: controller,
      builder: (context, _) => builder(controller),
    );
  }
}
