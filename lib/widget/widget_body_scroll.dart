import 'dart:ui';

import '../base_project/package_widget.dart';

class WidgetBodyScroll extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final ScrollPhysics? scrollPhysics;
  final List<Widget>? bodyListWidget;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? backGroundColor, titleColor;
  const WidgetBodyScroll({
    super.key,
    this.title,
    this.leadingIcon,
    this.bodyListWidget,
    this.scrollPhysics,
    this.trailing,
    this.padding, this.backGroundColor,
    this.titleColor
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          _body(context),
          _appbar(context),
        ],
      ),
    );
  }

  Widget _appbar(BuildContext context) {
    bool canPop = Navigator.canPop(context);
    Color bgAppBar = (backGroundColor ?? MyColor.white).withOpacity(0.7);
    return SizedBox(
      height: 100.w,
      width: Common.screen(context, be: Be.width),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: ColoredBox(
            color: bgAppBar,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 50.w, 20.w, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: ()=> !canPop ? null : Navigator.pop(context),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: (canPop && leadingIcon == null) ? Padding(
                          padding: EdgeInsets.all(4.w),
                          child: Center(child: Icon(Icons.arrow_back_ios_new, size: 17.sp, color: titleColor ?? MyColor.white)),
                        ) : leadingIcon ?? const SizedBox(),
                      ),
                      Text(title ?? '', style: Styles.def.bold.setColor(titleColor ?? MyColor.white).setTextSize(17)),
                    ]),
                  ),
                  SizedBox(width: 10.w),
                  trailing != null ? SizedBox(
                    height: 30.w,
                    width: 30.w,
                    child: Container(
                      decoration: const BoxDecoration(
                         shape: BoxShape.circle
                      ),
                      child: Center(
                        child: trailing ?? const SizedBox(),
                      ),
                    ),
                  ) : SizedBox(width: 30.w)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return ListView(
      physics: scrollPhysics ?? const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
      padding: padding ?? EdgeInsets.only(bottom: 50.w, top: 110.w, left: 10, right: 10),
      children: bodyListWidget ?? []
    );
  }
}