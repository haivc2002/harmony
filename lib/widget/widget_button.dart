import 'package:harmony/base_project/package_widget.dart';

class WidgetButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? color;
  final String textButton;
  final double? radius;
  final EdgeInsetsGeometry? margin, padding;
  final TextStyle? styleText;

  const WidgetButton({
    super.key,
    this.onTap,
    this.color,
    required this.textButton,
    this.radius,
    this.margin,
    this.styleText,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? 7)),
      child: Material(
        color: color ?? MyColor.white,
        borderRadius: BorderRadius.circular(radius ?? 7),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius ?? 7),
          onTap: onTap,
          child: Center(
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(vertical: 10.w),
              child: Text(textButton, style: styleText),
            ),
          ),
        ),
      ),
    );
  }
}