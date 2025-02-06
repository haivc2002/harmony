import 'dart:async';
import 'dart:ui';

import '../base_project/package_widget.dart';

class WidgetTabScreen extends StatefulWidget {
  final List<WidgetListPage> listPage;
  final WidgetDrawer drawer;
  final Color backGround;
  final String contentOutApp;
  const WidgetTabScreen({
    super.key,
    required this.listPage,
    required this.drawer,
    this.backGround = MyColor.white,
    required this.contentOutApp,
  });

  @override
  State<WidgetTabScreen> createState() => WidgetTabScreenState();
}

class WidgetTabScreenState extends State<WidgetTabScreen> with SingleTickerProviderStateMixin {

  late _WidgetTabController _controller;
  static late AnimationController animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = _WidgetTabController(context, widget.listPage);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
      context.read<WidgetBloc>().add(_WidgetEvent(scaleValue: animationController.value));
    });
    _animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    );
    super.initState();
  }

  static void _open() => animationController.forward();

  static void _close() => animationController.reverse();

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetBloc, _WidgetState>(
      builder: (context, state) {
        return PopScope(
          canPop: state.isCanPop,
          onPopInvokedWithResult: (didPop, result) {
            if(!state.isCanPop) {
              if(state.currentIndex != 0) {
                context.read<WidgetBloc>().add(_WidgetEvent(currentIndex: 0));
                _controller.navigationHandling(0, state);
              } else {
                _controller._showContent(widget.contentOutApp);
              }
            }
          },
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 300),
            tween: ColorTween(end: widget.backGround, begin: widget.backGround),
            builder: (context, value, child) {
              return Scaffold(
                backgroundColor: value,
                body: Stack(
                  children: [
                    _screen(state),
                    _touchingCloseDrawer(state),
                    _drawer(state),
                    if(state.scaleValue != 0) _touchingArea(),
                  ],
                ),
              );
            }
          ),
        );
      }
    );
  }

  Widget _screen(_WidgetState state) {
    return Transform.scale(
      alignment: Alignment.topRight,
      scale: 1 - state.scaleValue/20,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          widget.listPage[state.currentIndex].page,
          Positioned(
            bottom: 20.w,
            right: 17.w,
            left: 17.w,
            child: _WidgetTabMenu(
                state: state,
                controller: _controller,
                listPage: widget.listPage,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _touchingCloseDrawer(_WidgetState state) {
    return Visibility(
      visible: state.scaleValue != 0,
      child: GestureDetector(
        onTap: ()=> animationController.reverse(),
        child: ColoredBox(
          color: MyColor.black.withValues(alpha: state.scaleValue/2),
          child: SizedBox(
            height: Utilities.screen(context).h,
            width: Utilities.screen(context).w,
          ),
        )
      ),
    );
  }

  Widget _drawer(_WidgetState state) {
    return Visibility(
      visible: state.scaleValue != 0,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          double translateX = widget.drawer.width * animationController.value;
          return Transform.translate(
            offset: Offset(-widget.drawer.width + translateX, 0),
            child: child,
          );
        },
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.drawer.width,
              decoration: BoxDecoration(
                color: widget.drawer.backGroundColor?.opacity5 ?? Colors.black45,
                border: Border(
                  right: BorderSide(color: MyColor.grey.opacity2, width: 1)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.w, 10.w, 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    ...widget.drawer.children
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _touchingArea() {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        animationController.value += details.primaryDelta! / widget.drawer.width;
      },
      onHorizontalDragEnd: (details) {
        if (animationController.value > 0.5) {
          animationController.forward();
        } else {
          animationController.reverse();
        }
      },
    );
  }
}

class _WidgetTabController {
  BuildContext context;
  List<WidgetListPage> listPage;
  _WidgetTabController(this.context, this.listPage);

  void navigationHandling(int index, _WidgetState state) {
    bool canAct = false;
    context.read<WidgetBloc>().add(_WidgetEvent(currentIndex: index, canAct: canAct));
  }

  void _showContent(String title) {
    OverlayEntry? overlayEntry;
    final overlayContext = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: _OverlayContentWidget(
            onClose: () => overlayEntry?.remove(),
            resetCanPop: ()=> context.read<WidgetBloc>().add(_WidgetEvent(isCanPop: false)),
            contentOutApp: title,
          ),
        ),
      ),
    );
    context.read<WidgetBloc>().add(_WidgetEvent(isCanPop: true));
    overlayContext.insert(overlayEntry);
  }
}

class _WidgetTabMenu extends StatelessWidget {
  final _WidgetState state;
  final _WidgetTabController controller;
  final List<WidgetListPage> listPage;
  const _WidgetTabMenu({
    required this.state,
    required this.controller,
    required this.listPage,
  });

  @override
  Widget build(BuildContext context) {
    double withBtn = (Utilities.screen(context).w - 46.w)/controller.listPage.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 50.w,
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 6.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.opacity4),
              color: MyColor.black.opacity4,
              borderRadius: BorderRadius.circular(100.w)
          ),
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                width: withBtn,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: MyColor.pink.opacity7,
                    borderRadius: BorderRadius.circular(100.w)
                ),
                margin: EdgeInsets.only(left: withBtn * state.currentIndex),
              ),
              Row(children: List.generate(controller.listPage.length, (index) {
                bool isSelect = state.currentIndex == index;
                return Expanded(
                  child: IconButton(
                    onPressed: ()=> controller.navigationHandling(index, state),
                    icon: TweenAnimationBuilder(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween<double>(end: isSelect ? 1 : 0, begin: isSelect ? 1 : 0),
                        curve: Curves.ease,
                        builder: (context, value, child) {
                          double blurValue = isSelect ? 5 - (value * 5) : 0;
                          return Stack(
                            children: [
                              Transform.translate(
                                  offset: Offset(0, -(value * 5).w),
                                  child: Center(child: Icon(listPage[index].bottomIcon, color: MyColor.white.opacity7))
                              ),
                              Transform.translate(
                                  offset: Offset(0, value * 9.w),
                                  child: Center(child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaY: blurValue, sigmaX: blurValue),
                                      child: Transform.scale(
                                          scale: value,
                                          child: Text(listPage[index].name, style: Styles.def.setTextSize(9).bold.setColor(MyColor.white))
                                      ))
                                  )
                              )
                            ],
                          );
                        }
                    ),
                  ),
                );
              })),
            ],
          ),
        ),
      ),
    );
  }
}

class _WidgetState {
  bool canAct;
  int currentIndex;
  double scaleValue;
  bool isCanPop;

  _WidgetState({
    this.canAct = true,
    this.currentIndex = 0,
    this.scaleValue = 0,
    this.isCanPop = false,
  });
}

class _WidgetEvent {
  bool? canAct;
  int? currentIndex;
  double? scaleValue;
  bool? isCanPop;

  _WidgetEvent({this.canAct, this.currentIndex, this.scaleValue, this.isCanPop});
}

class WidgetBloc extends Bloc<_WidgetEvent, _WidgetState> {
  WidgetBloc() : super(_WidgetState()) {
    on<_WidgetEvent>((event, emit) {
      emit(_WidgetState(
          canAct: event.canAct ?? state.canAct,
          currentIndex: event.currentIndex ?? state.currentIndex,
          scaleValue: event.scaleValue ?? state.scaleValue,
          isCanPop: event.isCanPop ?? state.isCanPop,
      ));
    });
  }
}

class WidgetListPage {
  Widget page;
  IconData bottomIcon;
  String name;

  WidgetListPage({required this.page, required this.bottomIcon, required this.name});
}

class WidgetDrawer {
  Widget header;
  Color? colorHeader, backGroundColor;
  List<Widget> children;
  double width;

  static void open()=> WidgetTabScreenState._open();

  static void close() => WidgetTabScreenState._close();

  WidgetDrawer({required this.children, required this.header, this.width = 250, this.colorHeader, this.backGroundColor});
}

class _OverlayContentWidget extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback resetCanPop;
  final String contentOutApp;

  const _OverlayContentWidget({
    required this.onClose,
    required this.resetCanPop,
    required this.contentOutApp,
  });

  @override
  State<_OverlayContentWidget> createState() => _OverlayContentWidgetState();
}

class _OverlayContentWidgetState extends State<_OverlayContentWidget> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => opacity = 0.0);

      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onClose();
        widget.resetCanPop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10.0),
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        child: Text(
          widget.contentOutApp,
          style: Styles.def.setColor(MyColor.white).setTextSize(13).bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


