import '../base_project/package_widget.dart';

extension GradientColor on LinearGradient {
  static LinearGradient get blackBackgroundInLogin {
    return LinearGradient(
        colors: [MyColor.black.withOpacity(0.4), MyColor.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
    );
  }
}