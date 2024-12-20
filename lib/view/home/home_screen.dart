import 'package:harmony/base_project/color_ui/theme_ui.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'home_controller.dart';

class HomeScreen extends BaseView<HomeController> {
  static const String router = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  HomeController controller(BuildContext context) => HomeController(context);

  @override
  Widget build(BuildContext context, BaseState system, HomeController controller) {
    return Scaffold(
      backgroundColor: system.colorUi.deep,
      body: WidgetBodyScroll(
        title: "Home",
        color: system.colorUi.deep,
        bodyListWidget: [
          ElevatedButton(
            onPressed: ()=> controller.onChangeColorUi(ThemeUi.dark),
            child: Text("ChangeTheme")
          ),
          ElevatedButton(
            onPressed: ()=> controller.onChangeColorUi(ThemeUi.light),
            child: Text("ChangeTheme")
          )
        ]
      ),
    );
  }

}