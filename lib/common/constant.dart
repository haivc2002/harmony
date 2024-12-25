import 'package:harmony/base_project/package_widget.dart';

class Constant {
  static const String _dark = "dark";
  static const String _light = "light";

  static const String _vi = "vi";
  static const String _en = "en";

  static String colorGetStore = "colorUi";
  static String languageStore = "languageUi";

  // todo: Language system

  static Map<String, String> languageUi(String language) {
    switch (language) {
      case _vi:
        return Vi.language;
      default:
        return En.language;
    }
  }

  static String languageSetStore({required Map<String, String> kLanguage}) {
    if(Vi.language == kLanguage) {
      return _vi;
    } else {
      return _en;
    }
  }

  // todo: Color Ui

  static Map<String, Color> colorUi(String color) {
    switch (color) {
      case _dark:
        return ThemeUi.dark;
      default:
        return ThemeUi.light;
    }
  }

  static String colorSetStore({required Map<String, Color> themeUi}) {
    if(ThemeUi.dark == themeUi) {
      return _dark;
    } else {
      return _light;
    }
  }
}