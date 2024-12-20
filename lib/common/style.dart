import 'package:harmony/base_project/package_widget.dart';

class Styles {
  Styles(this.context);

  BuildContext? context;
  static TextStyle def = TextStyle(
    fontSize: 12.sp,
    color: MyColor.black,
    fontWeight: FontWeight.w400,
  );
}

extension ExtendedTextStyle on TextStyle {
  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get appbarTitle {
    return copyWith(fontSize: 18.sp, color: MyColor.pink);
  }

  TextStyle get whiteText {
    return copyWith(color: MyColor.white);
  }

  TextStyle get systemColor {
    return copyWith(color: MyColor.white);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }
}