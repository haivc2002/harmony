import '../base_project/package_widget.dart';
import 'package:badges/badges.dart' as badges;

class WidgetBadges extends StatelessWidget {
  const WidgetBadges({super.key, required this.child, this.value, this.showBadges = true, this.top, this.end});

  final Widget child;
  final int? value;
  final bool? showBadges;
  final double? top, end;

  String _val() {
    if(value == 0 || value == null) {
      return "";
    } else if((value ?? 0) > 10) {
      return "10+";
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: showBadges!,
      position: badges.BadgePosition.topEnd(top: -(top ?? 8.w), end: -(end ?? 6.w)),
      badgeContent: Text(_val(), style: Styles.def.bold
          .setTextSize(9.w).setColor(MyColor.white)),
      badgeAnimation: const badges.BadgeAnimation.scale(),
      child: child,
    );
  }
}
