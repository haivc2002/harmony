import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harmony/base_project/base_controller.dart';
import 'package:harmony/base_project/bloc/base_bloc.dart';

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView({super.key});

  static final Map<Type, BaseController> _controllers = {};
  static final Map<Type, BuildContext> _contexts = {};
  static final Map<Type, BaseState> _os = {};

  Widget build();

  T createController(BuildContext context);

  T get controller {
    if (_controllers[T] == null) throw Exception('Controller not initialized');
    return _controllers[T] as T;
  }

  BuildContext get context {
    if (_contexts[T] == null) throw Exception('Context not initialized');
    return _contexts[T]!;
  }

  BaseState get os {
    if(_os[T] == null) throw Exception('os not initialized');
    return _os[T]!;
  }

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  late T controller;

  @override
  void initState() {
    super.initState();
    controller = widget.createController(context);
    BaseView._controllers[T] = controller;
    BaseView._contexts[T] = context;
    BaseView._os[T] = context.read<BaseBloc>().state;
    controller.create(context);
  }

  @override
  void dispose() {
    controller.onDispose();
    BaseView._controllers.remove(T);
    BaseView._contexts.remove(T);
    BaseView._os.remove(T);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, system) {
        BaseView._os[T] = system;
        return widget.build();
      },
    );
  }
}












