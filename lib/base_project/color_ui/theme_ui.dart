import 'package:harmony/base_project/package_widget.dart';

class ThemeUi {
  static Map<String, Color> dark = {
    'deep': const Color(0xFF17212B),
    'fade': const Color(0xFF242F3D),
    'reverse': MyColor.white,
    'border': MyColor.white.withOpacity(0.1),
    'drawer': const Color(0xFF1C1C1E).withOpacity(0.7)
  };

  static Map<String, Color> light = {
    'deep': MyColor.white,
    'fade': const Color(0xFFF1F1F1),
    'reverse': Colors.black54,
    'border': Colors.grey.withOpacity(0.2),
    'drawer': const Color(0xFFD1D1D6).withOpacity(0.7)
  };
}