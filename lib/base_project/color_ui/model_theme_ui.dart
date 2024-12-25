import 'package:harmony/base_project/package_widget.dart';

class ModelThemeUi {
  Color deep, fade, reverse, border, drawer;
  ModelThemeUi({
    required this.deep,
    required this.fade,
    required this.reverse,
    required this.border,
    required this.drawer
  });

  factory ModelThemeUi.fromMap(Map<String, Color> map) {
    return ModelThemeUi(
      deep: map['deep'] ?? MyColor.white,
      fade: map['fade'] ?? const Color(0xFFF1F1F1),
      reverse: map['reverse'] ?? Colors.black54,
      border: map['border'] ?? Colors.grey.withOpacity(0.2),
      drawer: map['drawer'] ?? Colors.grey.withOpacity(0.2),
    );
  }

  Map<String, Color> toMap() {
    return {
      'deep': deep,
      'fade': fade,
      'reverse': reverse,
      'border': border,
      'drawer': drawer
    };
  }
}