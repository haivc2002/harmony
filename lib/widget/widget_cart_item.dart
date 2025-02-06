import 'package:harmony/base_project/package_widget.dart';

class WidgetCartItem extends StatelessWidget {
  const WidgetCartItem({
    super.key,
    this.color = MyColor.white,
    this.padding, this.leading,
    this.trailing, required this.title,
    this.textColor = MyColor.black,
    this.body, this.subTitle,
    this.mainAxisAlignment
  });

  final Color color, textColor;
  final EdgeInsetsGeometry? padding;
  final Widget? leading, trailing, body;
  final String title;
  final String? subTitle;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: ColoredBox(
        color: color,
        child: SizedBox(
          width: Utilities.screen(context).w,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            child: Column(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: SizedBox(
                    width: Utilities.screen(context).w * 0.8,
                    child: Row(children: [
                      if(leading != null) leading!,
                      SizedBox(width: leading != null ? 10.w : 0),
                      Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title, style: Styles.def.setColor(textColor).setTextSize(13.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                            if(subTitle != null) Text(subTitle!, style: Styles.def.setColor(textColor.opacity8), maxLines: 1, overflow: TextOverflow.ellipsis),
                          ]
                      )),
                      SizedBox(width: trailing != null ? 10.w : 0),
                      if(trailing != null) trailing!,
                    ]),
                  ),
                ),
                if(body != null) body!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
