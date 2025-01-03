import 'dart:ui';

import '../base_project/package_widget.dart';

class WidgetImageStack extends StatefulWidget {
  const WidgetImageStack({super.key, this.color, this.size, this.images});

  final Color? color;
  final double? size;
  final List<String>? images;

  @override
  State<WidgetImageStack> createState() => _WidgetImageStackState();
}

class _WidgetImageStackState extends State<WidgetImageStack> {

  List<String> _newList = [];
  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void initState() {
    _newList = (widget.images ?? []).reversed.toList();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
    super.initState();
  }

  double _scale(int index) {
    double result = 1 - (_currentPage - index).abs();
    result = result.clamp(0.0, 1.0);
    if(index == _currentPage.toInt()) {
      return result;
    } else {
      return 1;
    }
  }

  double _blur(int index) {
    double blur = 40 - (_scale(index) * 40);
    return blur;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        return Container(
          width: widget.size ?? size,
          height: widget.size ?? size,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10.w),
          ),
          padding: EdgeInsets.all(7.w),
          child: _newList.isNotEmpty ? _imageItem(size) : Text("data"),
        );
      },
    );
  }

  Widget _imageItem(double size) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Positioned.fill(child: PageView.builder(
          scrollDirection: Axis.vertical,
          controller: _pageController,
          itemCount: _newList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.only(top: index == _currentPage.toInt() ? 0 : 10),
              child: Transform.scale(
                scale: _scale(index),
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      (8 + (15 - 8) * (1 - (_scale(index) - 0.8) / 0.2)).w
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(_newList[index], fit: BoxFit.cover),
                      BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: _blur(index), sigmaY: _blur(index)),
                          child: const SizedBox()
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )),
        if(_newList.length > 1) _slide(size)
      ],
    );
  }

  Widget _slide(double size) {
    double sizeSlide = ((size / 2) - 2.w) / _newList.length;
    return Container(
      width: 4.w,
      height: size / 2,
      margin: EdgeInsets.only(right: 5.w),
      padding: EdgeInsets.all(1.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.w),
        color: const Color(0xFF545353),
        boxShadow: [
          BoxShadow(
            color: MyColor.black.withOpacity(0.5),
            blurRadius: 9,
            spreadRadius: 5
          )
        ]
      ),
      child: Column(children: [
        AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
          padding: EdgeInsets.only(top: sizeSlide * _currentPage.round()),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.w),
            child: SizedBox(
              height: sizeSlide,
              width: double.infinity,
              child: const ColoredBox(color: MyColor.white),
            ),
          ),
        ),
        const Spacer()
      ]),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

