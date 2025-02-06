import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/tab_multi/bloc/tab_multi_bloc.dart';

class TabMultiController extends BaseController {
  TabMultiController(super.context);

  @override
  void onInitState() {
    bool isDark = ThemeUi.dark == colorUi.keyDecode(Global.getString(Constant.colorGetStore));
    context.read<TabMultiBloc>().add(TabMultiEvent(isDark: isDark));
    super.onInitState();
  }

  void onChangeUI(bool value) {
    onChangeColorUi(themeUi: value ? ThemeUi.dark : ThemeUi.light);
    context.read<TabMultiBloc>().add(TabMultiEvent(isDark: value));
  }

  late OnLogOut onLogOut = OnLogOut(this);

}

class OnLogOut {
  TabMultiController controller;
  OnLogOut(this.controller);

  void perform(BaseState os) {
    WidgetDrawer.close();
    Utilities.dialog(
      controller.context,
      title: os.language.message,
      content: Text(os.language.contentLogOut),
      actions: [
        Utilities.dialog.action(
          onPressed: ()=> Navigator.pop(controller.context),
          child: Text(os.language.no, style: Styles.def.setColor(MyColor.red).setTextSize(14.sp))
        ),
        Utilities.dialog.action(
          onPressed: ()=> Navigator.pop(controller.context),
          child: Text(os.language.ok)
        )
      ]
    );
  }
}
