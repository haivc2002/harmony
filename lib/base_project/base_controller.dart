import 'package:harmony/base_project/color_ui/model_theme_ui.dart';
import 'package:harmony/base_project/language.dart';
import 'package:harmony/base_project/package_widget.dart';

class BaseController {
  BuildContext context;
  BaseController(this.context);

  void create(BuildContext context) {
    this.context = context;
    onInitState();
  }

  void onInitState() {}

  void onDispose() {}

  void onChangeLanguage(Map<String, String> langMap) async {
    Common.onLoading(context);
    await Future.delayed(const Duration(milliseconds: 500));
    if(context.mounted) {
      final language = Language.fromMap(langMap);
      if(context.mounted) context.read<BaseBloc>().add(BaseEvent(language: language));
      Common.onHideLoad(context);
    }
  }

  void onChangeColorUi(Map<String, Color> colorMap) {
    final color = ModelThemeUi.fromMap(colorMap);
    context.read<BaseBloc>().add(BaseEvent(colorUi: color));
  }

  void onSuccess<B>(E) {
    final bloc = context.read<B>();
    if (bloc is Bloc<dynamic, dynamic>) {
      bloc.add(E);
    } else {
      throw Exception('B must be a Bloc with an add() method.');
    }
  }

  void onLoad() {}

  void onError() {

  }

}