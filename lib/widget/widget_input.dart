import 'package:harmony/base_project/package_widget.dart';

class WidgetInput extends StatelessWidget {
  final TextEditingController? controller;
  final Color? colorInput, colorText, labelColor;
  final int? maxLines, maxLength;
  final String? labelText, validate;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final bool? hidePass;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  const WidgetInput({
    super.key,
    this.controller,
    this.colorInput,
    this.labelText,
    this.onTap,
    this.keyboardType,
    this.hidePass,
    this.focusNode,
    this.onChanged,
    this.maxLines,
    this.maxLength,
    this.colorText,
    this.labelColor,
    this.validate,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.w),
      clipBehavior: Clip.antiAlias,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          border: validate!.isNotEmpty 
              ? Border.all(color: MyColor.red, width: 1.5)
              : Border.all(color: MyColor.white.withOpacity(0.4))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.w, width: double.infinity, child: ColoredBox(color: colorInput ?? Colors.transparent)),
            TextField(
              maxLength: maxLength,
              maxLines: maxLines ?? 1,
              onChanged: onChanged,
              focusNode: focusNode,
              obscureText: hidePass == true ? true: false,
              onTap: onTap,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                filled: true,
                fillColor: colorInput ?? Colors.transparent,
                labelText: validate!.isNotEmpty ? validate : labelText,
                labelStyle: validate!.isNotEmpty
                  ? const TextStyle(color: MyColor.red)
                  : TextStyle(color: labelColor ?? MyColor.white.withOpacity(0.5)),
                suffixIcon: suffixIcon,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(0),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
              ),
              style: Styles.def.setColor(colorText ?? MyColor.black),
              keyboardType: keyboardType,
              // textInputAction: TextInputAction.done,
              cursorColor: MyColor.pink,
            ),
          ],
        ),
      )
    );
  }
}