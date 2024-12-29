
import 'package:harmony/view/match/match_controller.dart';

import '../../base_project/package_widget.dart';

class MatchScreen extends BaseView<MatchController> {
  static const String router = "/MatchScreen";
  const MatchScreen({super.key});

  @override
  MatchController controller(BuildContext context)=> MatchController(context);

  @override
  Widget build(BuildContext context, BaseState system, MatchController controller) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WidgetBodyScroll(
        title: system.language.titleMatch,
        titleColor: system.colorUi.reverse,
        backGroundColor: system.colorUi.deep,
      ),
    );
  }
}



