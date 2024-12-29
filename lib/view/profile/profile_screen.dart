import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/profile/profile_controller.dart';


class ProfileScreen extends BaseView<ProfileController> {
  static const String router = '/ProfileScreen';
  const ProfileScreen({super.key});

  @override
  ProfileController controller(BuildContext context) => ProfileController(context);

  @override
  Widget build(BuildContext context, BaseState system, ProfileController controller) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xFFB2B8C4),
            // Color(0xFFFFFFFF),
            // Color(0xFF8296AE),
            Color(0xFF465B72),
            Color(0xFF17212B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: WidgetBodyScroll(
          title: system.language.titleProfile,
          titleColor: system.colorUi.reverse,
          backGroundColor: system.colorUi.deep,
          bodyListWidget: [
          ],
        ),
      ),
    );
  }

}
