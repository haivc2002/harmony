import 'dart:ui';

import '../base_project/package_widget.dart';

class WidgetBodyScroll extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final TextStyle? textStyle;
  final ScrollPhysics? scrollPhysics;
  final List<Widget>? bodyListWidget;
  final TextAlign? textAlign;
  final Widget? trailing;
  final bool? showLeading;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  const WidgetBodyScroll({
    super.key,
    this.title,
    this.leadingIcon,
    this.textStyle,
    this.bodyListWidget,
    this.scrollPhysics,
    this.textAlign,
    this.trailing,
    this.showLeading,
    this.padding, this.color
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
    return SizedBox(
      height: 100.w,
      width: Common.screen(context, be: Be.width),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: ColoredBox(
            color: (color ?? MyColor.white).withOpacity(0.7),
            child: Column(
              children: [
                SizedBox(height: 50.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      showLeading ?? true == true ? Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
                        child: SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Material(
                                  color: Colors.transparent,
                                  child: (Navigator.canPop(context) && leadingIcon == null) ? InkWell(
                                    onTap: ()=> Navigator.pop(context),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 17.sp,
                                        ),
                                      ),
                                    ),
                                  ) : leadingIcon ?? const SizedBox()
                              ),
                            ),
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                      Expanded(child: Text(title ?? '', style: textStyle, textAlign: textAlign)),
                      SizedBox(width: 20.w),
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
                )
              ],
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