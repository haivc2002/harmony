
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/base_common.dart';
import 'package:harmony/widget/wait.dart';
import '../base_project/package_widget.dart';

class Utilities {

  static screen(BuildContext context) => _Screen(context);

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

  static void popupError(BuildContext context, {required Object code}) {
    String title = "";
    final os = context.read<BaseBloc>().state;
    if(code.runtimeType == String) title = code.toString();
    if(code.runtimeType == int) {
      switch(code) {
        case Result.isHttp: title = os.language.isHttp;
        case Result.isDueServer: title = os.language.isDueServer;
        case Result.isNotConnect: title = os.language.isNotConnect;
        case Result.isTimeOut: title = os.language.isTimeOut;
        default: title = os.language.isHttp;
      }
    }
    showCupertinoDialog(context: context, builder: (context) {
      return CupertinoTheme(
        data: const CupertinoThemeData(brightness: Brightness.dark),
        child: CupertinoAlertDialog(
          title: Text(os.language.message, style: Styles.def
              .setColor(MyColor.white.withValues(alpha: 0.7))
              .bold.setTextSize(14.sp)),
          content: Text(title,style: Styles.def.setColor(MyColor.white.withValues(alpha: 0.7))),
          actions: [CupertinoDialogAction(
            child: Text(os.language.ok, style: Styles.def.setColor(MyColor.blue)),
            onPressed: () => Navigator.pop(context),
          )],
        ),
      );
    });
  }

  static final dialog = _DialogHelper();
}

class _Screen {
  BuildContext context;
  _Screen(this.context);

  double get h => MediaQuery.of(context).size.height;
  double get w => MediaQuery.of(context).size.width;
}

class _DialogHelper with BaseCommon {
  void call(BuildContext context, {String? title, Widget? content, List<Widget>? actions}) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoTheme(
          data: const CupertinoThemeData(brightness: Brightness.dark),
          child: CupertinoAlertDialog(
            title: Text(title ?? "Message"),
            content: content,
            actions: actions ?? [],
          ),
        );
      },
    );
  }

  Widget action({required Widget child, Function()? onPressed}) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      child: child,
    );
  }
}
