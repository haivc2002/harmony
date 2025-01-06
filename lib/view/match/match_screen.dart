import 'dart:ui';

import 'package:harmony/view/match/match_controller.dart';

import '../../base_project/package_widget.dart';

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
          itemBuilder: (context, index) => _itemMatches(index)
        )
      ),
    );
  }
  
  Widget _itemMatches(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.w),
      child: AspectRatio(
        aspectRatio: controller.randomSizeItem.perform(index),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: controller.list[index],
              fit: BoxFit.cover,
            ),
            ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.black.withOpacity(0)],
                        stops: [controller.randomSizeItem.perform(index) == 1.0 ? 0.7 : 0.8, 0.0]
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstOut,
                  child: CachedNetworkImage(
                    imageUrl: controller.list[index],
                    fit: BoxFit.cover,
                  ),
                )
            ),
          ],
        ),
      ),
    );


  }
}



