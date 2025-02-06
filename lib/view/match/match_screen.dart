import 'dart:ui';

import 'package:harmony/view/match/match_controller.dart';

import '../../base_project/package_widget.dart';
import '../../widget/widget_item_parallax.dart';

class MatchScreen extends BaseView<MatchController> {
  static const String router = "/MatchScreen";
  const MatchScreen({super.key});

  @override
  MatchController createController(BuildContext context)=> MatchController(context);

  @override
  Widget build() {
    return Scaffold(
      backgroundColor: os.colorUi.deep,
      body: WidgetBodyScroll(
        title: os.language.titleMatch,
        titleColor: os.colorUi.reverse,
        backGroundColor: os.colorUi.deep,
        buildType: BuildTypeData.nonsense(
          itemCount: controller.list.length,
          itemBuilder: (context, index) => WidgetItemParallax(
            aspectRatio: controller.randomSizeItem.perform(index),
            image: controller.list[index],
            stop: controller.randomSizeItem.perform(index) == 1.0 ? 0.65 : 0.75,
            name: "Huowng, 20",
            subTitle: "Dating",
          )
        )
      ),
    );
  }
}



