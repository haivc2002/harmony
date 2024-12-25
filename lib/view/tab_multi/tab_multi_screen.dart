import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/home/home_screen.dart';
import 'package:harmony/view/tab_multi/tab_multi_controller.dart';


class TabMultiScreen extends BaseView<TabMultiController> {
  static const String router = "/TabMultiScreen";
  const TabMultiScreen({super.key});

  @override
  TabMultiController controller(BuildContext context) => TabMultiController(context);

  @override
  Widget build(BuildContext context, BaseState system, TabMultiController controller) {
    return WidgetTabScreen(
      backGround: system.colorUi.deep,
      listPage: [
        WidgetListPage(
            page: const HomeScreen(),
            bottomIcon: Icons.favorite,
            name: system.language.titleHome
        ),
        WidgetListPage(
            page: Container(),
            bottomIcon: Icons.dashboard,
            name: system.language.titleMatch
        ),
        WidgetListPage(
            page: Container(color: MyColor.white),
            bottomIcon: CupertinoIcons.chat_bubble_fill,
            name: system.language.titleMessage
        ),
        WidgetListPage(
            page: Container(color: MyColor.white),
            bottomIcon: Icons.person,
            name: system.language.titleProfile
        ),
      ],
      drawer: WidgetDrawer(
          header: Container(),
          backGroundColor: system.colorUi.drawer,
          children: [
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.light),
                icon: Icon(CupertinoIcons.add)
            ),
            IconButton(
                onPressed: ()=> controller.onChangeColorUi(themeUi: ThemeUi.dark),
                icon: Icon(CupertinoIcons.add)
            ),
            SwitchListTile(
                value: true,
                title: Text("data"),
                activeColor: MyColor.white,
                activeTrackColor: MyColor.pink,
                onChanged: (value) {},
            )
          ]
      )
    );
  }

}