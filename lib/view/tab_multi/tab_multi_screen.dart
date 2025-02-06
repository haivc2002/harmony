import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/explorer/explorer_screen.dart';
import 'package:harmony/view/home/home_screen.dart';
import 'package:harmony/view/message/message_screen.dart';
import 'package:harmony/view/profile/profile_screen.dart';
import 'package:harmony/view/setting/setting_screen.dart';
import 'package:harmony/view/tab_multi/bloc/tab_multi_bloc.dart';
import 'package:harmony/view/tab_multi/tab_multi_controller.dart';

class TabMultiScreen extends BaseView<TabMultiController> {
  static const String router = "/TabMultiScreen";
  const TabMultiScreen({super.key});

  @override
  TabMultiController createController(BuildContext context) => TabMultiController(context);

  @override
  Widget build() {
    return BlocBuilder<TabMultiBloc, TabMultiState>(
      builder: (context, state) {
        return WidgetTabScreen(
          contentOutApp: os.language.contentOutApp,
          backGround: os.colorUi.deep,
          listPage: [
            WidgetListPage(
                page: const HomeScreen(),
                bottomIcon: Icons.favorite,
                name: os.language.titleHome
            ),
            WidgetListPage(
                page: const ExplorerScreen(),
                bottomIcon: Icons.dashboard,
                name: os.language.titleExplorer
            ),
            WidgetListPage(
                page: const MessageScreen(),
                bottomIcon: CupertinoIcons.chat_bubble_fill,
                name: os.language.titleMessage
            ),
            WidgetListPage(
                page: const ProfileScreen(),
                bottomIcon: Icons.person,
                name: os.language.titleProfile
            ),
          ],
          drawer: _drawer(state)
        );
      }
    );
  }

  WidgetDrawer _drawer(TabMultiState state) {
    return WidgetDrawer(
        header: Container(),
        backGroundColor: os.colorUi.deep,
        children: [
          IconButton(
              onPressed: ()=> controller.onChangeLanguage(En.language),
              icon: Icon(CupertinoIcons.add)
          ),
          IconButton(
              onPressed: ()=> controller.onChangeLanguage(Vi.language),
              icon: Icon(CupertinoIcons.add)
          ),
          IconButton(
              onPressed: ()=> controller.onChangeLanguage(Zh.language),
              icon: Icon(CupertinoIcons.add)
          ),
          _itemDrawer(
              icon: CupertinoIcons.settings,
              title: os.language.setting,
              onTap: ()=> Navigator.pushNamed(context, SettingScreen.router)
          ),
          const Spacer(),
          SwitchListTile(
            value: state.isDark,
            title: AutoSizeText(os.language.drawerDarkMode, style: Styles.def.setColor(os.colorUi.reverse)),
            contentPadding: EdgeInsets.zero,
            activeColor: MyColor.white,
            activeTrackColor: MyColor.pink,
            inactiveTrackColor: const Color(0xFF424242).opacity7,
            inactiveThumbColor: MyColor.white,
            onChanged: (value) => controller.onChangeUI(value),
          ),
          SizedBox(height: 10.w),
          WidgetButton(
            textButton: os.language.titleLogout,
            styleText: Styles.def.setTextSize(10.sp).bold.setColor(os.colorUi.reverse),
            color: os.colorUi.fade.opacity3,
            onTap: ()=> controller.onLogOut.perform(os),
          ),
          SizedBox(height: 100.w),
        ]
    );
  }

  Widget _itemDrawer({required IconData icon, required String title, required Function() onTap}) {
    return GestureDetector(
      onTap: () {
        WidgetDrawer.close();
        onTap();
      },
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.w),
          child: ColoredBox(
            color: os.colorUi.reverse.opacity2,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(icon, color: os.colorUi.reverse),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(child: Text(title, style: Styles.def.setColor(os.colorUi.reverse).setTextSize(14.sp),
          maxLines: 2, overflow: TextOverflow.ellipsis,
        )),
        Icon(Icons.navigate_next, color: os.colorUi.reverse.opacity2)
      ]),
    );
  }

}