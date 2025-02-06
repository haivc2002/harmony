import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/home/bloc/home_bloc.dart';

final class HomeController extends BaseController {
  HomeController(super.context);

  final double heightAppbar = 100.w;
  late final SwipableStackController stackController;

  late BlurImageStackBehind behind = BlurImageStackBehind(this);
  late ScaleImageStackBehind scale = ScaleImageStackBehind(this);

  @override
  void onInitState() {
    context.read<HomeBloc>().add(HomeEvent());
    stackController = SwipableStackController()..addListener(_listenController);
    super.onInitState();
  }

  @override
  void onDispose() {
    stackController
      ..removeListener(_listenController)
      ..dispose();
    super.onDispose();
  }

  void _listenController() {
    context.read<HomeBloc>().add(HomeEvent(currentIndex: stackController.currentIndex));
  }

  List<Color> f = [MyColor.red, MyColor.black, MyColor.pink];

}

class BlurImageStackBehind {
  final HomeController _controller;
  BlurImageStackBehind(this._controller);

  double value(double positioned, int index) {
    double result = 20 - positioned * 4;
    result = result > 0 ? result : 0;
    if(_controller.stackController.currentIndex == index) {
      return 0;
    } else {
      return result;
    }
  }
}

class ScaleImageStackBehind {
  final HomeController _controller;
  ScaleImageStackBehind(this._controller);

  double value(double positioned, int index) {
    double result = 0.3 - positioned * 0.1;
    result = result.clamp(0.0, 0.3);
    if(_controller.stackController.currentIndex == index) {
      return 0.0;
    } else {
      return result;
    }
  }
}