import 'package:harmony/base_project/color_ui/theme_ui.dart';
import 'package:harmony/base_project/color_ui/model_theme_ui.dart';
import 'package:harmony/base_project/language.dart';
import 'package:harmony/base_project/package_widget.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseState(
      language: Language.fromMap(En.language),
      colorUi: ModelThemeUi.fromMap(ThemeUi.light)
  )) {
    on<BaseEvent>((event, emit) {
      emit(BaseState(
        language: event.language ?? state.language,
        colorUi: event.colorUi ?? state.colorUi
      ));
    });
  }
}
