import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/base_project/base_controller.dart';
import 'package:harmony/base_project/bloc/base_bloc.dart';

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView({super.key});

  Widget build(BuildContext context, BaseState system, T controller);

  T controller(BuildContext context);

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  late T controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller(context);
    controller.create(context);
  }

  @override
  void dispose() {
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, system) {
        return widget.build(context, system, controller);
      },
    );
  }
}











