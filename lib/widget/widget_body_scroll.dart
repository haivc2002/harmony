import 'dart:ui';

import '../base_project/package_widget.dart';

enum BuildType { base, list, grid, nonsense}

typedef ItemBuilder = Widget Function(BuildContext context, int index);

class WidgetBodyScroll extends StatelessWidget {
  final String? title;
  final Widget? leadingIcon;
  final bool? showIconLeading;
  final ScrollPhysics? scrollPhysics;
  final BuildTypeData buildType;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? backGroundColor, titleColor;
  const WidgetBodyScroll({
    super.key,
    this.title,
    this.leadingIcon,
    required this.buildType,
    this.scrollPhysics,
    this.trailing,
    this.padding, this.backGroundColor,
    this.titleColor, this.showIconLeading = true
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
                    onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: (Navigator.canPop(context) && leadingIcon == null || showIconLeading!) ? Padding(
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
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Center(child: trailing ?? const SizedBox()),
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

  // Widget _body(BuildContext context) {
  //   return AnimationLimiter(
  //     child: ListView(
  //       physics: scrollPhysics ?? const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
  //       padding: padding ?? EdgeInsets.only(bottom: 50.w, top: 10.w, left: 10, right: 10),
  //       children: [
  //         SizedBox(height: 100.w),
  //         ...AnimationConfiguration.toStaggeredList(
  //           duration: const Duration(milliseconds: 375),
  //           childAnimationBuilder: (widget) => SlideAnimation(
  //             horizontalOffset: 50.0,
  //             child: FadeInAnimation(
  //               child: widget,
  //             ),
  //           ),
  //           children: bodyListWidget ?? [],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _body(BuildContext context) => buildType.build(scrollPhysics, padding);

}

class BuildTypeData {
  final BuildType type;
  final List<Widget>? children;
  final ItemBuilder? itemBuilder;
  final int? itemCount;
  final int crossAxisCount;

  BuildTypeData._({
    required this.type,
    this.children,
    this.itemBuilder,
    this.itemCount,
    this.crossAxisCount = 2,
  });

  static BuildTypeData list({
    required ItemBuilder itemBuilder,
    int? itemCount,
  }) {
    return BuildTypeData._(
      type: BuildType.list,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }

  static BuildTypeData base({
    required List<Widget> children,
  }) {
    return BuildTypeData._(
      type: BuildType.base,
      children: [SizedBox(height: 100.w), ...children],
    );
  }

  static BuildTypeData grid({
    required ItemBuilder itemBuilder,
    int? itemCount,
    int crossAxisCount = 2,
  }) {
    return BuildTypeData._(
      type: BuildType.grid,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      crossAxisCount: crossAxisCount,
    );
  }

  static BuildTypeData nonsense({
    required ItemBuilder itemBuilder,
    int? itemCount,
  }) {
    return BuildTypeData._(
      type: BuildType.nonsense,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
    );
  }

  Widget build(ScrollPhysics? physics, EdgeInsetsGeometry? padding) {
    switch (type) {
      case BuildType.list:
        return ListView.builder(
          padding: padding ?? EdgeInsets.only(top: 100.w, left: 10.w, right: 10.w, bottom: 50.w),
          physics: physics ?? const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
          itemCount: itemCount ?? 0,
          itemBuilder: itemBuilder!,
        );
      case BuildType.grid:
        return GridView.builder(
          padding: padding ?? EdgeInsets.only(top: 100.w, left: 10.w, right: 10.w, bottom: 50.w),
          physics: physics ?? const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: itemCount ?? 0,
          itemBuilder: itemBuilder!,
        );
      case BuildType.nonsense:
        return MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.w,
          padding: padding ?? EdgeInsets.only(top: 110.w, left: 10.w, right: 10.w, bottom: 50.w),
          physics: const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
          itemCount: itemCount ?? 0,
          itemBuilder: itemBuilder!,
        );
      case BuildType.base:
      default:
        return ListView(
          padding: padding ?? EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w, bottom: 50.w),
          physics: physics ?? const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
          children: children ?? [],
        );
    }
  }
}