import 'package:harmony/base_project/language.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'base_common.dart';

class BaseController with BaseCommon {
  BuildContext context;
  BaseController(this.context);

  final args = null;

  M? onCreateArgument<M>() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is M) return args;
    return null;
  }

  void onInitState() {}

  void onDispose() {}

  void onChangeLanguage(Map<String, String> langMap) async {
    Utilities.onLoading(context);
    await Future.delayed(const Duration(milliseconds: 500));
    if(context.mounted) {
      final language = Language.fromMap(langMap);
      if(context.mounted) context.read<BaseBloc>().add(BaseEvent(language: language));
      Global.setString(Constant.languageStore, langUi.keyEncode(kLanguage: langMap));
      Utilities.onHideLoad(context);
    }
  }

  void onChangeColorUi({required Map<String, Color> themeUi}) {
    final color = ModelThemeUi.fromMap(themeUi);
    context.read<BaseBloc>().add(BaseEvent(colorUi: color));
    Global.setString(Constant.colorGetStore, colorUi.keyEncode(themeUi: themeUi));
  }

  void _addEventToBloc<B>(dynamic event) {
    final bloc = context.read<B>();
    if (bloc is Bloc<dynamic, dynamic>) {
      bloc.add(event);
    } else {
      throw Exception('${B.toString()} must be a Bloc with an add() method.');
    }
  }

  void onLoad<B>(dynamic event) => _addEventToBloc<B>(event);

  void onSuccess<B>(dynamic event) => _addEventToBloc<B>(event);

  void onError<B>(dynamic event) => _addEventToBloc<B>(event);

}