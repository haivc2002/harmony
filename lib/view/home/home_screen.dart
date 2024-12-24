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
        title: system.language.titleHome,
        backGroundColor: system.colorUi.deep,
        titleColor: system.colorUi.reverse,
        leadingIcon: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: system.colorUi.reverse)
        ),
        bodyListWidget: [
          ElevatedButton(
            onPressed: ()=> controller.onChangeColorUi(ThemeUi.dark),
            child: Text("ChangeTheme")
          ),
          ElevatedButton(
            onPressed: ()=> controller.onChangeColorUi(ThemeUi.light),
            child: Text("ChangeTheme")
          ),

          Image.network("https://scontent.fhan4-1.fna.fbcdn.net/v/t39.30808-6/47119323"
              "0_1142996377195845_7838792820522151134_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=1"
              "27cfc&_nc_eui2=AeF7Wz1Z0XX3VGv8IZHA8s4KmLLOBld91tCYss4GV33W0DUqJli10Ht8pD"
              "BPYo2bk--c6QIAW5tV-pxMRaXmzBE6&_nc_ohc=KAdTEcrO-wQQ7kNvgFF4-Zn&_nc_oc=Adg"
              "V6zThWqfMduY2X_gdi7mKdcGmslxcXuNpZn6WZgHaHj5bfLM0aonwDOXOLRm8kXk&_nc_zt=2"
              "3&_nc_ht=scontent.fhan4-1.fna&_nc_gid=AyFPaqI9_MAly0QFs"
              "AxhSJz&oh=00_AYCtO_uZmUi3REpqVGWgAWIxE1j1ktouxZfCOhtGgsbAZw&oe=676ED6FF"),
        ]
      ),
    );
  }

}