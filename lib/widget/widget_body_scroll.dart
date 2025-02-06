import 'dart:ui';

import '../base_project/package_widget.dart';

enum BuildType {base, list, grid, nonsense}
enum Type {scale, fade, none}

typedef ItemBuilder = Widget Function(BuildContext context, int index);

class WidgetBodyScroll extends StatelessWidget {
  final String? title;
  final bool? showIconLeading;
  final ScrollPhysics? scrollPhysics;
  final BuildTypeData buildType;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? backGroundColor, titleColor;
  final LeadingIcon? leadingIcon;
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
    Color bgAppBar = (backGroundColor ?? MyColor.white).withValues(alpha: 0.7);
    return SizedBox(
      height: 100.w,
      width: Utilities.screen(context).w,
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
                    onTap: () {
                      if(leadingIcon?.action == null) {
                        Navigator.canPop(context) ? Navigator.pop(context) : null;
                      } else {
                        (leadingIcon?.action??(){})();
                      }
                    },
                    child: Row(children: [
                      _leadIcon(context),
                      SizedBox(width: 10.w),
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

  Widget _body(BuildContext context) => buildType.build(scrollPhysics, padding);

  Widget _leadIcon(BuildContext context) {
    if(leadingIcon == null) {
      if(Navigator.canPop(context) || showIconLeading!) {
        return Padding(
          padding: EdgeInsets.all(4.w),
          child: Center(child: Icon(Icons.arrow_back_ios_new, size: 17.sp, color: titleColor ?? MyColor.white)),
        );
      } else {
        return const SizedBox();
      }
    } else {
      return leadingIcon?.icon ?? const SizedBox();
    }
  }

}

class BuildTypeData {
  final BuildType type;
  final List<Widget>? children;
  final ItemBuilder? itemBuilder;
  final int? itemCount;
  final int crossAxisCount;
  final TypeAnimation? typeAnimation;

  BuildTypeData._({
    required this.type,
    this.children,
    this.itemBuilder,
    this.itemCount,
    this.typeAnimation,
    this.crossAxisCount = 2,
  });

  static BuildTypeData list({
    required ItemBuilder itemBuilder,
    int? itemCount,
    TypeAnimation? typeAnimation,
  }) {
    return BuildTypeData._(
      type: BuildType.list,
      itemBuilder: itemBuilder,
      typeAnimation: typeAnimation ?? TypeAnimation(type: Type.fade),
      itemCount: itemCount,
    );
  }

  static BuildTypeData base({
    required List<Widget> children,
    TypeAnimation? typeAnimation,
  }) {
    return BuildTypeData._(
      type: BuildType.base,
      typeAnimation: typeAnimation ?? TypeAnimation(type: Type.fade),
      children: [SizedBox(height: 100.w), ...children],
    );
  }

  static BuildTypeData grid({
    required ItemBuilder itemBuilder,
    int? itemCount,
    TypeAnimation? typeAnimation,
    int crossAxisCount = 2,
  }) {
    return BuildTypeData._(
      type: BuildType.grid,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      typeAnimation: typeAnimation ?? TypeAnimation(type: Type.fade),
      crossAxisCount: crossAxisCount,
    );
  }

  static BuildTypeData nonsense({
    required ItemBuilder itemBuilder,
    TypeAnimation? typeAnimation,
    int? itemCount,
  }) {
    return BuildTypeData._(
      type: BuildType.nonsense,
      itemBuilder: itemBuilder,
      typeAnimation: typeAnimation ?? TypeAnimation(type: Type.fade),
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
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: _itemAnimated(context, index, typeAnimation),
          ),
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
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: _itemAnimated(context, index, typeAnimation),
          ),
        );
      case BuildType.nonsense:
        return AnimationLimiter(
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8.w,
            crossAxisSpacing: 8.w,
            padding: padding ?? EdgeInsets.only(top: 110.w, left: 10.w, right: 10.w, bottom: 50.w),
            physics: const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
            itemCount: itemCount ?? 0,
            itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: _itemAnimated(context, index, typeAnimation),
            ),
          ),
        );
      case BuildType.base:
      return ListView(
          padding: padding ?? EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w, bottom: 50.w),
          physics: physics ?? const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics()),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => _itemAnimatedBase(widget, typeAnimation),
            children: children ?? [],
          ),
        );
    }
  }

  Widget _itemAnimated(BuildContext context, int index, TypeAnimation? typeAnimation) {
    if (typeAnimation == null) return itemBuilder!(context, index);
    switch (typeAnimation.type) {
      case Type.scale:
        return SlideAnimation(
          verticalOffset: typeAnimation.vertical,
          horizontalOffset: typeAnimation.horizontal,
          child: ScaleAnimation(
            child: itemBuilder!(context, index),
          ),
        );
      case Type.fade:
        return SlideAnimation(
          verticalOffset: typeAnimation.vertical,
          horizontalOffset: typeAnimation.horizontal,
          child: FadeInAnimation(
            child: itemBuilder!(context, index),
          ),
        );
      case Type.none:
        return itemBuilder!(context, index);
    }
  }

  Widget _itemAnimatedBase(Widget widget, TypeAnimation? typeAnimation) {
    if (typeAnimation == null) return widget;
    switch (typeAnimation.type) {
      case Type.scale:
        return SlideAnimation(
          verticalOffset: typeAnimation.vertical,
          horizontalOffset: typeAnimation.horizontal,
          child: ScaleAnimation(
            child: widget,
          ),
        );
      case Type.fade:
        return SlideAnimation(
          verticalOffset: typeAnimation.vertical,
          horizontalOffset: typeAnimation.horizontal,
          child: FadeInAnimation(
            child: widget,
          ),
        );
      case Type.none:
        return widget;
    }
  }
}

class LeadingIcon {
  final Widget icon;
  final Function()? action;

  LeadingIcon({required this.icon, required this.action});
}

class TypeAnimation {
  Type type;
  double? horizontal;
  double? vertical;

  TypeAnimation({required this.type, this.horizontal = 0, this.vertical = 50});
}