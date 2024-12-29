import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'bloc/home_bloc.dart';
import 'home_controller.dart';

class HomeScreen extends BaseView<HomeController> {
  static const String router = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  HomeController controller(BuildContext context) => HomeController(context);

  @override
  Widget build(BuildContext context, BaseState system, HomeController controller) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: ColorTween(begin: system.colorUi.deep, end: system.colorUi.deep),
        builder: (context, value, child) {
          return WidgetBodyScroll(
            title: system.language.titleHome,
            backGroundColor: value,
            titleColor: system.colorUi.reverse,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            leadingIcon: IconButton(
              onPressed: ()=> WidgetDrawer.open(context),
              icon: Icon(Icons.menu, color: system.colorUi.reverse)
            ),
            bodyListWidget: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: Common.screen(context, be: Be.height) - controller.heightAppbar,
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: SwipableStack(
                        detectableSwipeDirections: const {
                          SwipeDirection.right,
                          SwipeDirection.left,
                        },
                        controller: controller.stackController,
                        horizontalSwipeThreshold: 0.8,
                        verticalSwipeThreshold: 0.8,
                        stackClipBehaviour: Clip.none,
                        itemCount: controller.f.length,
                        builder: (context, properties) {
                          final itemIndex = properties.index % controller.f.length;
                          return GestureDetector(
                            onTap: ()=> print(itemIndex),
                            child: _itemCard(
                                context: context,
                                system: system,
                                controller: controller,
                                positioned: properties.swipeProgress,
                                itemIndex: itemIndex,
                                state: state
                            )
                          );
                        },
                      ),
                    ),
                  );
                }
              )
            ]
          );
        }
      ),
    );
  }

  Widget _itemCard({
    required BuildContext context,
    required BaseState system,
    required HomeController controller,
    required double positioned,
    required HomeState state,
    required int itemIndex
  }) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.w),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(controller.scale.value(positioned, itemIndex)),
              alignment: Alignment.topCenter,
              child: Image.network(
                "https://instagram.fhan4-1.fna.fbcdn.net/v/t51.29350-15/"
                    "471632782_626329443158173_4891858443551876560_n.jpg?"
                    "stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6ImltYWdlX3"
                    "VybGdlbi4xMDgweDE4Njguc2RyLmYyOTM1MC5kZWZhdWx0X2ltYWd"
                    "lIn0&_nc_ht=instagram.fhan4-1.fna.fbcdn.net&_nc_cat=1&"
                    "_nc_oc=Q6cZ2AHWjeT1-AXLJKrcWh7mzObFKkh0kU4XGX6xmv_fmSkY"
                    "H3xxxOK8ULcilg3P8xxC9FI&_nc_ohc=Kp1-KmNd8ewQ7kNvgE38m-M"
                    "&_nc_gid=66b326b0cd59445babd0dbcb43106f99&edm=AHedtMEBAA"
                    "AA&ccb=7-5&ig_cache_key=MzUzMDgzNDIxMDcyMDM3MTcwNA%3D%3D"
                    ".3-ccb7-5&oh=00_AYCL9txRgA3A0UEuMpC7RsxOwKKS36weEUX0YBTP"
                    "GktVKQ&oe=6772FAAE&_nc_sid=a3cc6e", fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(20.w)),
          child: SizedBox(
            height: 70.w,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: GradientColor.blackBackgroundNameHuman
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Huowng • 22 tuoi", style: Styles.def.bold.setColor(MyColor.white).setTextSize(16.sp)),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: MyColor.pink,
                        borderRadius: BorderRadius.circular(100.w)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.location_on_rounded, color: MyColor.white, size: 15.sp),
                          SizedBox(width: 6.w),
                          Text("data", style: Styles.def.setColor(MyColor.white).bold),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaY: controller.behind.value(positioned, itemIndex),
                sigmaX: controller.behind.value(positioned, itemIndex)
            ),
            child: const SizedBox(),
          ),
        ),
      ],
    );
  }

}