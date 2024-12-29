import 'package:harmony/base_project/language.dart';
import 'package:harmony/base_project/package_widget.dart';

class BaseController {
  BuildContext context;
  BaseController(this.context);

  final args = null;

  void create(BuildContext context) {
    this.context = context;
    onInitState();
  }

  T? onCreateArgument<T>() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is T) return args;
    return null;
  }

  void onInitState() {}

  void onDispose() {}

  void onChangeLanguage(Map<String, String> langMap) async {
    Common.onLoading(context);
    await Future.delayed(const Duration(milliseconds: 500));
    if(context.mounted) {
      final language = Language.fromMap(langMap);
      if(context.mounted) context.read<BaseBloc>().add(BaseEvent(language: language));
      Global.setString(Constant.languageStore, Constant.languageSetStore(kLanguage: langMap));
      Common.onHideLoad(context);
    }
  }

  void onChangeColorUi({required Map<String, Color> themeUi}) {
    final color = ModelThemeUi.fromMap(themeUi);
    context.read<BaseBloc>().add(BaseEvent(colorUi: color));
    Global.setString(Constant.colorGetStore, Constant.colorSetStore(themeUi: themeUi));
  }

  void onSuccess<B>(E) {
    final bloc = context.read<B>();
    if (bloc is Bloc<dynamic, dynamic>) {
      bloc.add(E);
    } else {
      throw Exception('B must be a Bloc with an add() method.');
    }
  }

  void onLoad<B, E>() {
    final bloc = context.read<B>();
    if(bloc is Bloc<dynamic, dynamic>) {
      bloc.add(E);
    } else {
      throw Exception('B must be a Bloc with an add() method.');
    }
  }

  void onError() {}

}