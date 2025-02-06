import 'dart:ui';
import 'package:harmony/base_project/package_widget.dart';

class WidgetItemParallax extends StatelessWidget {
  final double aspectRatio;
  final double? stop;
  final String? name, subTitle;
  final bool? isNew;
  final String image;
  const WidgetItemParallax({
    super.key,
    this.isNew = false,
    required this.aspectRatio,
    required this.image, this.stop,
    this.name = '', this.subTitle = ""
  });

  @override
  Widget build(BuildContext context) {
    return WidgetBadges(
      end: 1.w,
      showBadges: isNew,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _image(context),
              _bottomImage(context),
              _backGradient()
            ],
          ),
        ),
      ),
    );
  }

  Widget _image(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        itemContext: context,
      ),
      children: [CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
      )],
    );
  }

  Widget _bottomImage(BuildContext context) {
    return ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.black.opacity0],
              stops: [stop ?? 0.7, 0.0]
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Flow(
            delegate: ParallaxFlowDelegate(
              scrollable: Scrollable.of(context),
              itemContext: context,
            ),
            children: [CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
            )],
          ),
        )
    );
  }

  Widget _backGradient() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 50.w,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(gradient: GradientColor.blackInItemParallax),
          child: Padding(
            padding: EdgeInsets.fromLTRB(8.w, 2.w, 8.w, 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name!, style: Styles.def.bold.setColor(MyColor.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                Expanded(child: Text(subTitle!, style: Styles.def.bold.setColor(MyColor.pink)))
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState? scrollable;
  final BuildContext itemContext;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
  }) : super(repaint: scrollable?.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) =>
      BoxConstraints.tightFor(width: constraints.maxWidth);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (scrollable == null) return;

    final scrollableBox = scrollable!.context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      itemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );
    final viewportDimension = scrollable!.position.viewportDimension;
    final scrollFraction =
    (itemOffset.dy / viewportDimension).clamp(0, 1);
    final verticalAlignment = Alignment(0, scrollFraction * 2 - 1);
    final imageBox = context.getChildSize(0)!;
    final childRect = verticalAlignment.inscribe(imageBox, Offset.zero & context.size);
    context.paintChild(0, transform: Transform.translate(offset: Offset(0, childRect.top)).transform);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => true;
}
