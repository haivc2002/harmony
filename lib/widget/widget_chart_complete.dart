import '../base_project/package_widget.dart';

class WidgetChartComplete extends StatelessWidget {
  const WidgetChartComplete({
    super.key,
    this.color,
    required this.value,
    required this.title,
    this.titleColor
  });

  final Color? color, titleColor;
  final int value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10.w),
      color: color,
      child: Padding(
        padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 10.w, bottom: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _complete(),
            SizedBox(height: 4.w),
            _chart()
          ],
        ),
      ),
    );
  }

  Widget _complete() {
    return FutureBuilder<double>(
      future: Future.delayed(const Duration(milliseconds: 500), () => value.toDouble()),
      initialData: 0,
      builder: (context, snapshot) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: snapshot.data ?? 0),
          duration: const Duration(seconds: 2),
          curve: Curves.ease,
          builder: (context, double animatedValue, child) {
            return Row(children: [
              Expanded(
                child: AutoSizeText(
                  "$title: ",
                  style: Styles.def.setColor(titleColor ?? MyColor.black),
                  maxLines: 1,
                ),
              ),
              Text(
                "${animatedValue.toInt()}%",
                style: Styles.def.setColor(titleColor ?? MyColor.black),
              ),
            ]);
          },
        );
      },
    );
  }

  Widget _chart() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          return ColoredBox(
            color: MyColor.grey,
            child: Row(children: [
              FutureBuilder<double>(
                future: Future.delayed(const Duration(milliseconds: 500), () => maxWidth * value / 100),
                initialData: 0,
                builder: (context, snapshot) {
                  return TweenAnimationBuilder(
                    duration: const Duration(seconds: 2),
                    tween: Tween<double>(begin: 0, end: snapshot.data ?? 0),
                    curve: Curves.ease,
                    builder: (context, animatedWidth, child) {
                      return SizedBox(
                        height: 5.w,
                        width: animatedWidth,
                        child: const ColoredBox(color: MyColor.pink),
                      );
                    },
                  );
                },
              ),
              const Spacer(),
            ]),
          );
        },
      ),
    );

  }
}
