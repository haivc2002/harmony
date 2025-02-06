import 'package:harmony/base_project/base_common.dart';
import 'package:harmony/base_project/language.dart';
import 'package:harmony/base_project/package_widget.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseState(
      language: Language.fromMap(BaseCommon.initLang.keyDecode(Global.getString(Constant.languageStore))),
      colorUi: ModelThemeUi.fromMap(BaseCommon.initColor.keyDecode(Global.getString(Constant.colorGetStore)))
  )) {
    on<BaseEvent>((event, emit) {
      emit(BaseState(
        language: event.language ?? state.language,
        colorUi: event.colorUi ?? state.colorUi
      ));
    });
  }
}
