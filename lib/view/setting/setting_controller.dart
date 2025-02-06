import 'package:harmony/base_project/package_widget.dart';

class SettingController extends BaseController {
  SettingController(super.context);

  @override
  void onInitState() {
    var s = Global.getString(Constant.languageStore);
    print(s);
    super.onInitState();
  }
}