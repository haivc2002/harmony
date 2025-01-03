import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/home/bloc/home_bloc.dart';

class HomeController extends BaseController {
  HomeController(super.context);

  final double heightAppbar = 100.w;
  late final SwipableStackController stackController;

  late BlurImageStackBehind behind = BlurImageStackBehind(context, stackController);
  late ScaleImageStackBehind scale = ScaleImageStackBehind(context, stackController);

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
  BuildContext context;
  final SwipableStackController _stackController;
  BlurImageStackBehind(this.context, this._stackController);

  double value(double positioned, int index) {
    double result = 20 - positioned * 4;
    result = result > 0 ? result : 0;
    if(_stackController.currentIndex == index) {
      return 0;
    } else {
      return result;
    }
  }
}

class ScaleImageStackBehind {
  BuildContext context;
  final SwipableStackController _stackController;
  ScaleImageStackBehind(this.context, this._stackController);

  double value(double positioned, int index) {
    double result = 0.3 - positioned * 0.1;
    result = result.clamp(0.0, 0.3);
    if(_stackController.currentIndex == index) {
      return 0.0;
    } else {
      return result;
    }
  }
}