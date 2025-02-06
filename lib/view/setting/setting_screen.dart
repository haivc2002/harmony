import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/setting/setting_controller.dart';

class SettingScreen extends BaseView<SettingController> {
  static const String router = "/SettingScreen";
  const SettingScreen({super.key});

  @override
  SettingController createController(BuildContext context) => SettingController(context);

  @override
  Widget build() {
    return Scaffold(
      backgroundColor: os.colorUi.deep,
      body: WidgetBodyScroll(
        title: os.language.setting,
        titleColor: os.colorUi.reverse,
        backGroundColor: os.colorUi.deep,
        buildType: BuildTypeData.base(
          typeAnimation: TypeAnimation(type: Type.fade, horizontal: 50.w, vertical: 0),
          children: [
            WidgetPopupItem(
              boxItem: _itemLanguage(),
              child: WidgetCartItem(
                leading: Icon(Icons.g_translate, color: MyColor.blue),
                color: os.colorUi.fade,
                title: os.language.language,
                textColor: os.colorUi.reverse,
                trailing: Text("🇻🇳"),
              ),
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.dark),
                icon: Text("Dark blue")
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.light),
                icon: Text("white")
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.absoluteBlack),
                icon: Text("black")
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.purpleCharcoal),
                icon: Text("purpleCharcoal")
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.purpleFade),
                icon: Text("purpleFade")
            ),

            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.blueWhite),
                icon: Text("blueWhite")
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.browFade),
                icon: Text("browFade")
            ),
            Text("🇻🇳"),
            Text("🇬🇧"),
          ]
        )
      ),
    );
  }

  Widget _itemLanguage() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Utilities.screen(context).w * 0.8,
        maxHeight: Utilities.screen(context).h / 2
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: ColoredBox(
          color: os.colorUi.fade,
          child: IntrinsicHeight(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
                child: Row(children: [
                  Icon(Icons.language, color: MyColor.blue),
                  SizedBox(width: 10.w),
                  Text(os.language.changeLanguage, style: Styles.def.setColor(os.colorUi.reverse))
                ]),
              ),
              Text("viet nam"),
              Text("engligh")
            ]),
          ),
        ),
      ),
    );
  }

}