import 'package:flutter/material.dart';

class MyColor {
  static const Color black = Colors.black;
  static const Color pink = Color(0xFFFF6880);
  static const Color white = Color(0xFFFFFDF7);
  static const Color deepRed = Color(0xFFC8001A);
  static const Color red = Colors.red;
  static const Color grey = Color(0xFFC4C3C1);
  static const Color yellow = Color(0xFFF9DC8A);
  static const Color greenFade = Color(0xFFBBE2B7);
  static const Color blue = Colors.blue;
}

extension ColorOpacity on Color {
  Color get opacity0 => withValues(alpha: 0.0);
  Color get opacity1 => withValues(alpha: 0.1);
  Color get opacity2 => withValues(alpha: 0.2);
  Color get opacity3 => withValues(alpha: 0.3);
  Color get opacity4 => withValues(alpha: 0.4);
  Color get opacity5 => withValues(alpha: 0.5);
  Color get opacity6 => withValues(alpha: 0.6);
  Color get opacity7 => withValues(alpha: 0.7);
  Color get opacity8 => withValues(alpha: 0.8);
  Color get opacity9 => withValues(alpha: 0.9);
  Color get opacity10 => withValues(alpha: 1.0);
}