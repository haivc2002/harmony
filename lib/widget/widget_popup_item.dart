import 'dart:ui';

import 'package:harmony/base_project/package_widget.dart';

class WidgetPopupItem extends StatelessWidget {
  final Widget child, boxItem;
  WidgetPopupItem({super.key, required this.child, required this.boxItem});

  final Object _tag = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleBlur(),
      child: GestureDetector(
        onTap: ()=> _nextPage(context),
        child: Hero(
          tag: _tag,
          createRectTween: (begin, end) => _CustomRectTween(end: end!, begin: begin!),
          child: Material(color: Colors.transparent, child: child)
        )
      ),
    );
  }

  void _nextPage(BuildContext context) {
    context.read<ToggleBlur>().toggle();
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => _Popup(tag: _tag, item: boxItem),
    )).whenComplete(() {
      if(context.mounted) context.read<ToggleBlur>().toggle();
    });
  }
}

class _Popup extends StatelessWidget {
  final Object tag;
  final Widget item;
  const _Popup({required this.tag, required this.item});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<ToggleBlur, bool>(
          builder: (context, isBlur) {
            return GestureDetector(
              onTap: ()=> Navigator.pop(context),
              child: Material(
                color: Colors.transparent,
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: isBlur ? 10 : 0),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, child) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: value, sigmaX: value),
                      child: const SizedBox(),
                    );
                  }
                ),
              ),
            );
          }
        ),
        Center(child: Hero(
          tag: tag,
          createRectTween: (begin, end) => _CustomRectTween(end: end!, begin: begin!),
          child: Material(color: Colors.transparent, child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: item
          ))
        )),
      ],
    );
  }
}

class _CustomRectTween extends RectTween {
  _CustomRectTween({
    required Rect begin,
    required Rect end
  }) : super(begin: begin, end: end);

  Rect custom(double trans) {
    final elasticCurveValue = Curves.easeOut.transform(trans);
    return Rect.fromLTRB(
        lerpDouble(begin?.left, end?.left, elasticCurveValue)!,
        lerpDouble(begin?.top, end?.top, elasticCurveValue)!,
        lerpDouble(begin?.right, end?.right, elasticCurveValue)!,
        lerpDouble(begin?.bottom, end?.bottom, elasticCurveValue)!,
    );
  }

}

class ToggleBlur extends Cubit<bool> {
  ToggleBlur() : super(false);
  void toggle() => emit(!state);
}

