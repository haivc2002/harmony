import '../base_project/package_widget.dart';

extension GradientColor on LinearGradient {
  static LinearGradient get blackBackgroundInLogin {
    return LinearGradient(
        colors: [MyColor.black.opacity4, MyColor.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
  }

  static LinearGradient get blackBackgroundNameHuman {
    return LinearGradient(
        colors: [MyColor.black, MyColor.black.opacity0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
  }

  static LinearGradient get blackInItemParallax {
    return LinearGradient(
        colors: [MyColor.black.opacity5, MyColor.black.opacity0],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter
    );
  }
}