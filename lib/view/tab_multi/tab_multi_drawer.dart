import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../base_project/package_widget.dart';

class TabMultiDrawer extends StatelessWidget {
  const TabMultiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Drawer(
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: const SizedBox(),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    color: MyColor.red,
                    border: Border(
                        right: BorderSide(
                            color: MyColor.red
                        )
                    )
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(
                      height: 100.w,
                    ),
                    ListTile(
                      leading: SizedBox(),
                      title: Text("dkjfgsrhgr"),
                      subtitle: Text('asdkfjhaiuwehf'),
                      trailing: Text('asdkfjhaiuwehf'),
                    ),
                    itemDrawer(CupertinoIcons.profile_circled, 'Edit Personal information', () {}),
                    itemDrawer(Icons.settings,'Setting', () async {
                      // await Navigator.pushNamed(context, SettingScreen.routeName);
                      // widget.onRefresh();
                      // widget.swiController.currentIndex = 0;
                    }),
                    itemDrawer(Icons.logout,'Sign Out', () {}),
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: GestureDetector(
                onTap: () {

                },
                child: Container(color: Colors.transparent)
            )
        )
      ],
    );
  }

  Widget itemDrawer(IconData iconData, String titleItem, Function() onTap) {
    return ListTile(
      leading: Icon(iconData, color: Colors.black54),
      title: Text(titleItem, style: const TextStyle(color: Colors.black54)),
      trailing: Icon(Icons.arrow_forward_ios, size: 11.sp, color: Colors.black54),
      onTap: () {

      },
    );
  }
}
