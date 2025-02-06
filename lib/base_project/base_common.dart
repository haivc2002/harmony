import 'package:harmony/base_project/package_widget.dart';

mixin BaseCommon {
  LangUi get langUi => LangUi();
  static LangUi get initLang => LangUi();
  ColorUi get colorUi => ColorUi();
  static ColorUi get initColor => ColorUi();
}

class LangUi {
  static const String _vi = "vi";
  static const String _zh = "zh";
  static const String _en = "en";

  String keyEncode({required Map<String, String> kLanguage}) {
    if(kLanguage == Vi.language) return _vi;
    if(kLanguage == Zh.language) return _zh;
    return _en;
  }

  Map<String, String> keyDecode(String language) {
    switch (language) {
      case _vi: return Vi.language;
      case _zh: return Zh.language;
      default: return En.language;
    }
  }
}

class ColorUi {
  static const String _dark = "dark";
  static const String _light = "light";
  static const String _absoluteBlack = "absoluteBlack";
  static const String _purpleCharcoal = "purpleCharcoal";
  static const String _purpleFade = "purpleFade";
  static const String _blueWhite = "blueWhite";
  static const String _browFade = "browFade";

  Map<String, Color> keyDecode(String color) {
    switch (color) {
      case _dark: return ThemeUi.dark;
      case _absoluteBlack: return ThemeUi.absoluteBlack;
      case _purpleCharcoal: return ThemeUi.purpleCharcoal;
      case _purpleFade: return ThemeUi.purpleFade;
      case _blueWhite: return ThemeUi.blueWhite;
      case _browFade: return ThemeUi.browFade;
      default: return ThemeUi.light;
    }
  }

  String keyEncode({required Map<String, Color> themeUi}) {
    if(ThemeUi.dark == themeUi) return _dark;
    if(themeUi == ThemeUi.absoluteBlack) return _absoluteBlack;
    if(themeUi == ThemeUi.purpleCharcoal) return _purpleCharcoal;
    if(themeUi == ThemeUi.purpleFade) return _purpleFade;
    if(themeUi == ThemeUi.blueWhite) return _blueWhite;
    if(themeUi == ThemeUi.browFade) return _browFade;
    return _light;
  }
}