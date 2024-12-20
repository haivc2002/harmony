
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:harmony/widget/wait.dart';
import '../base_project/package_widget.dart';

class Common {
  static double screen(BuildContext context, {required Be be}) {
    if(Be.height == be) {
      return MediaQuery.of(context).size.height;
    } else {
      return MediaQuery.of(context).size.width;
    }
  }

  static void onLoading(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCupertinoDialog(context: context, builder: (context) {
        return TweenAnimationBuilder(
          tween: Tween<double>(end: 10, begin: 0),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
              child: const Center(child: Wait(color: MyColor.white, size: 40)),
            );
          }
        );
      });
    });
  }

  static void onHideLoad(BuildContext context) => Navigator.pop(context);

  static void popupError(BuildContext context) {
    showCupertinoDialog(context: context, builder: (context) {
      // return CupertinoAlertDialog(
      //
      //   title: Text("data"),
      //   actions: [
      //     Text("OK")
      //   ],
      // );
      return CupertinoDialogAction(child: Text("data"));
    });
  }
}