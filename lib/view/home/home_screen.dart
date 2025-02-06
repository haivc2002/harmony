import 'dart:ui';

import 'package:harmony/base_project/package_widget.dart';
import 'bloc/home_bloc.dart';
import 'home_controller.dart';

class HomeScreen extends BaseView<HomeController> {
  static const String router = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  HomeController createController(BuildContext context) => HomeController(context);

  @override
  Widget build() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 300),
        tween: ColorTween(begin: os.colorUi.deep, end: os.colorUi.deep),
        builder: (context, value, child) {
          return WidgetBodyScroll(
            title: os.language.titleHome,
            backGroundColor: value,
            titleColor: os.colorUi.reverse,
            showIconLeading: false,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            leadingIcon: LeadingIcon(
              icon: Icon(Icons.menu, color: os.colorUi.reverse),
              action: ()=> WidgetDrawer.open(),
            ),
            buildType: BuildTypeData.base(
              typeAnimation: TypeAnimation(type: Type.fade, horizontal: -60.w, vertical: 0),
              children: [BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      height: Utilities.screen(context).h - controller.heightAppbar,
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
                          onWillMoveNext: (index, direction) {
                            if (direction == SwipeDirection.left) {
                              print('Swiped Left');
                            } else if (direction == SwipeDirection.right) {
                              print('Swiped Right');
                            }
                            return true;
                          },

                          builder: (context, properties) {
                            final itemIndex = properties.index % controller.f.length;
                            return GestureDetector(
                                onTap: ()=> print(itemIndex),
                                child: _itemCard(
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
              )]
            )
          );
        }
      ),
    );
  }

  Widget _itemCard({
    required double positioned,
    required HomeState state,
    required int itemIndex
  }) {
    return Stack(children: [
      Positioned.fill(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.w),
          child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(controller.scale.value(positioned, itemIndex)),
            alignment: Alignment.topCenter,
            child: Image.network(
              "https://chontruong.org/wp-content/uploads/2024/09/anh-gai-xinh-3.jpg", fit: BoxFit.cover,
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
    ]);
  }

}