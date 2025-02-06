import 'package:harmony/base_project/package_widget.dart';

class ThemeUi {
  static Map<String, Color> dark = {
    'deep': const Color(0xFF17212B),
    'fade': const Color(0xFF242F3D),
    'reverse': MyColor.white,
    'border': MyColor.white.opacity1,
  };

  static Map<String, Color> light = {
    'deep': MyColor.white,
    'fade': const Color(0xFFF1F1F1),
    'reverse': Colors.black54,
    'border': Colors.grey.opacity2,
  };

  static Map<String, Color> absoluteBlack = {
    'deep': MyColor.black,
    'fade': const Color(0xFF181818),
    'reverse': MyColor.white,
    'border': const Color(0xFF383939),
  };

  static Map<String, Color> purpleCharcoal = {
    'deep': const Color(0xFF0E0E18),
    'fade': const Color(0xFF202037),
    'reverse': MyColor.white,
    'border': const Color(0xFF2F2F49),
  };

  static Map<String, Color> purpleFade = {
    'deep': const Color(0xFFF9F4FD),
    'fade': const Color(0xFFE4D9F1),
    'reverse': MyColor.black,
    'border': const Color(0xFFF6F6F6),
  };

  static Map<String, Color> blueWhite = {
    'deep': const Color(0xFFFFFFFF),
    'fade': const Color(0xFFDAEDFB),
    'reverse': MyColor.black,
    'border': Colors.grey.opacity2,
  };

  static Map<String, Color> browFade = {
    'deep': const Color(0xFFD9D1C2),
    'fade': const Color(0xFFFBFBFD),
    'reverse': MyColor.black,
    'border': Colors.grey.opacity2,
  };
}