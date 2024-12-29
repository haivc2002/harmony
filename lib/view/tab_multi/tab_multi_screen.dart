import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/home/home_screen.dart';
import 'package:harmony/view/match/match_screen.dart';
import 'package:harmony/view/message/message_screen.dart';
import 'package:harmony/view/profile/profile_screen.dart';
import 'package:harmony/view/tab_multi/bloc/tab_multi_bloc.dart';
import 'package:harmony/view/tab_multi/tab_multi_controller.dart';


class TabMultiScreen extends BaseView<TabMultiController> {
  static const String router = "/TabMultiScreen";
  const TabMultiScreen({super.key});

  @override
  TabMultiController controller(BuildContext context) => TabMultiController(context);

  @override
  Widget build(BuildContext context, BaseState system, TabMultiController controller) {
    return BlocBuilder<TabMultiBloc, TabMultiState>(
      builder: (context, state) {
        return WidgetTabScreen(
          backGround: system.colorUi.deep,
          listPage: [
            WidgetListPage(
                page: const HomeScreen(),
                bottomIcon: Icons.favorite,
                name: system.language.titleHome
            ),
            WidgetListPage(
                page: const MatchScreen(),
                bottomIcon: Icons.dashboard,
                name: system.language.titleMatch
            ),
            WidgetListPage(
                page: const MessageScreen(),
                bottomIcon: CupertinoIcons.chat_bubble_fill,
                name: system.language.titleMessage
            ),
            WidgetListPage(
                page: const ProfileScreen(),
                bottomIcon: Icons.person,
                name: system.language.titleProfile
            ),
          ],
          drawer: WidgetDrawer(
              header: Container(),
              backGroundColor: system.colorUi.drawer,
              children: [
                IconButton(
                    onPressed: ()=> controller.onChangeLanguage(En.language),
                    icon: Icon(CupertinoIcons.add)
                ),
                IconButton(
                    onPressed: ()=> controller.onChangeLanguage(Vi.language),
                    icon: Icon(CupertinoIcons.add)
                ),
                SwitchListTile(
                    value: state.isDark,
                    title: AutoSizeText(system.language.drawerDarkMode, style: Styles.def
                        .setColor(system.colorUi.reverse)
                    ),
                    activeColor: MyColor.white,
                    activeTrackColor: MyColor.pink,
                    inactiveTrackColor: const Color(0xFF424242).withOpacity(0.7),
                    inactiveThumbColor: MyColor.white,
                    onChanged: (value) => controller.onChangeUI.perform(value),
                )
              ]
          )
        );
      }
    );
  }

}