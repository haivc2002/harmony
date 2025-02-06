import 'package:harmony/base_project/package_widget.dart';

class ModelThemeUi {
  Color deep, fade, reverse, border;
  ModelThemeUi({
    required this.deep,
    required this.fade,
    required this.reverse,
    required this.border,
  });

  factory ModelThemeUi.fromMap(Map<String, Color> map) {
    return ModelThemeUi(
      deep: map['deep'] ?? MyColor.white,
      fade: map['fade'] ?? const Color(0xFFF1F1F1),
      reverse: map['reverse'] ?? Colors.black54,
      border: map['border'] ?? Colors.grey.opacity2,
    );
  }

  Map<String, Color> toMap() {
    return {
      'deep': deep,
      'fade': fade,
      'reverse': reverse,
      'border': border,
    };
  }
}