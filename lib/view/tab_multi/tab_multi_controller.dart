import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/tab_multi/bloc/tab_multi_bloc.dart';

class TabMultiController extends BaseController {
  TabMultiController(super.context);

  late bool isDark;

  late final OnChangeUI onChangeUI = OnChangeUI(context);

  @override
  void onInitState() {
    isDark = ThemeUi.dark == Constant.colorUi(Global.getString(Constant.colorGetStore));
    context.read<TabMultiBloc>().add(TabMultiEvent(isDark: isDark));
    super.onInitState();
  }
}

class OnChangeUI extends TabMultiController {
  OnChangeUI(super.context);

  void perform(bool value) {
    onChangeColorUi(themeUi: value ? ThemeUi.dark : ThemeUi.light);
    context.read<TabMultiBloc>().add(TabMultiEvent(isDark: value));
  }

}