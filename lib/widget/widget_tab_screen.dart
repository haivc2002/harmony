import 'dart:async';
import 'dart:ui';

import '../base_project/package_widget.dart';

// TODO: SCREEN
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
  late AnimationController animationController;
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
      curve: Curves.ease,
    );
    super.initState();
  }

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
        body: Stack(
          children: [
            IndexedStack(
              index: state.currentIndex,
              children: List.generate(widget.listPage.length, (index) {
                final isVisible = index == state.currentIndex;
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(begin: 100, end: _controller.valueSlate(isVisible, index, state)),
                  curve: Curves.ease,
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(value, 0),
                      child: Opacity(
                        opacity: 1 - (value.abs()/100),
                        child: widget.listPage[index].page
                      ),
                    );
                  }
                );
              }),
            ),
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
          ],
        ),
      ),
    );
  }

  Widget _touchingCloseDrawer(_WidgetState state) {
    return Visibility(
      visible: state.scaleValue != 0,
      child: GestureDetector(
        onTap: ()=> animationController.reverse(),
        child: ColoredBox(
          color: MyColor.black.withOpacity(state.scaleValue/2),
          child: SizedBox(
            height: Common.screen(context, be: Be.height),
            width: Common.screen(context, be: Be.width),
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.w, 50.w, 0, 10.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13.w),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: widget.drawer.width,
                decoration: BoxDecoration(
                  color: widget.drawer.backGroundColor?.withOpacity(0.6) ?? Colors.black45,
                  border: Border.all(color: widget.drawer.backGroundColor ?? MyColor.black, width: 2),
                  borderRadius: BorderRadius.circular(13.w)
                ),
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

// TODO: CONTROLLER
class _WidgetTabController {
  BuildContext context;
  List<WidgetListPage> listPage;
  _WidgetTabController(this.context, this.listPage);

  void navigationHandling(int index, _WidgetState state) {
    bool canAct = false;
    context.read<WidgetBloc>().add(_WidgetEvent(currentIndex: index, canAct: canAct));
  }

  double valueSlate(bool isVisible, int index, _WidgetState state) {
    if(!isVisible) {
      if (index < state.currentIndex) {
        return -100;
      } else if (index > state.currentIndex) {
        return 100;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
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

// TODO: MENU
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
    double withBtn = (Common.screen(context, be: Be.width) - 46.w)/controller.listPage.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.w),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          height: 50.w,
          padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 6.w),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
              color: MyColor.black.withOpacity(0.4),
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
                    color: MyColor.pink.withOpacity(0.7),
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
                                  child: Center(child: Icon(listPage[index].bottomIcon, color: MyColor.white.withOpacity(0.7)))
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

// TODO: BLOC STATE MANAGER
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

// TODO: MODEL PAGE PARAMS
class WidgetListPage {
  Widget page;
  IconData bottomIcon;
  String name;

  WidgetListPage({required this.page, required this.bottomIcon, required this.name});
}

// TODO: MODEL DRAWER
class WidgetDrawer {
  Widget header;
  Color? colorHeader, backGroundColor;
  List<Widget> children;
  double width;

  static void open(BuildContext context)=> context.findAncestorStateOfType<WidgetTabScreenState>()?.animationController.forward();

  static void close(BuildContext context)=> context.findAncestorStateOfType<WidgetTabScreenState>()?.animationController.reverse();

  WidgetDrawer({required this.children, required this.header, this.width = 250, this.colorHeader, this.backGroundColor});
}

// TODO: MANAGER ON BACK APP
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


