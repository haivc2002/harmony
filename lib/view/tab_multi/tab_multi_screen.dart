import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/explorer/explorer_screen.dart';
import 'package:harmony/view/home/home_screen.dart';
import 'package:harmony/view/message/message_screen.dart';
import 'package:harmony/view/profile/profile_screen.dart';
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
          drawer: WidgetDrawer(
              header: Container(),
              backGroundColor: os.colorUi.drawer,
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
                    title: AutoSizeText(os.language.drawerDarkMode, style: Styles.def
                        .setColor(os.colorUi.reverse)
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