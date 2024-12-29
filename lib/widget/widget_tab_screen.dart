import 'dart:async';
import 'dart:ui';

import '../base_project/package_widget.dart';

class WidgetTabScreen extends StatefulWidget {
  final List<WidgetListPage> listPage;
  final WidgetDrawer drawer;
  final Color backGround;
  const WidgetTabScreen({
    super.key,
    required this.listPage,
    required this.drawer,
    this.backGround = MyColor.white,
  });

  @override
  State<WidgetTabScreen> createState() => WidgetTabScreenState();
}

class WidgetTabScreenState extends State<WidgetTabScreen> with SingleTickerProviderStateMixin {

  late _WidgetTabController _controller;
  late PageController _pageController;
  late AnimationController animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _pageController = PageController();
    final state = context.read<WidgetBloc>().state;
    _controller = _WidgetTabController(context, widget.listPage, _pageController);
    if (widget.listPage.isNotEmpty) _controller._addFirst(widget.listPage[0].page, state);
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
        return TweenAnimationBuilder(
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
            PageView.builder(
              controller: _controller.pageController,
              itemCount: _controller.getList(state).length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _controller.getList(state)[index],
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

class _WidgetTabController {
  BuildContext context;
  List<WidgetListPage> listPage;
  PageController pageController;
  _WidgetTabController(this.context, this.listPage, this.pageController);

  final int _durationDefault = 300;

  void navigationHandling(int index, _WidgetState state) {
    if (!state.canAct || index == state.currentIndex) return;
    bool canAct = false;
    if (index < state.currentIndex) {
      pageController.jumpToPage(1);
      _addFirst(listPage[index].page, state);
    } else if (index > state.currentIndex) {
      _addLast(listPage[index].page, state);
    }
    context.read<WidgetBloc>().add(_WidgetEvent(currentIndex: index, canAct: canAct));
  }

  Future<void> _addFirst(Widget screen, _WidgetState state) async {
    Node<Widget> newNode = Node(screen);
    newNode.next = state.head;
    context.read<WidgetBloc>().add(_WidgetEvent(head: newNode));
    if (pageController.hasClients) {
      await pageController.previousPage(
        duration: Duration(milliseconds: _durationDefault * 2),
        curve: Curves.fastOutSlowIn,
      );
      Future.delayed(const Duration(milliseconds: 300), ()=> _removeLast());
    }
  }

  Future<void> _addLast(Widget data, _WidgetState state) async {
    Node<Widget> newNode = Node(data);
    if (state.head == null) {
      context.read<WidgetBloc>().add(_WidgetEvent(head: newNode));
    } else {
      Node<Widget>? current = state.head;
      while (current!.next != null) {
        current = current.next;
      }
      current.next = newNode;
      context.read<WidgetBloc>().add(_WidgetEvent(head: state.head));
    }
    if (pageController.hasClients) {
      pageController.nextPage(
        duration: Duration(milliseconds: _durationDefault),
        curve: Curves.ease,
      ).whenComplete(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        _removeFirst(state);
      });
    }
  }

  void _removeFirst(_WidgetState state) {
    if (state.head != null) {
      context.read<WidgetBloc>().add(_WidgetEvent(head: state.head!.next, canAct: true));
    }
  }

  void _removeLast() {
    final state = context.read<WidgetBloc>().state;
    if (state.head == null) return;
    if (state.head!.next == null) {
      context.read<WidgetBloc>().add(_WidgetEvent(head: null, canAct: true));
    } else {
      Node<Widget>? current = state.head;
      while (current!.next!.next != null) {
        current = current.next;
      }
      current.next = null;
      context.read<WidgetBloc>().add(_WidgetEvent(head: state.head, canAct: true));
    }
  }

  List<Widget> getList(_WidgetState state) {
    List<Widget> result = [];
    Node<Widget>? current = state.head;
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
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

class Node<Widget> {
  Widget data;
  Node<Widget>? next;

  Node(this.data);
}

class _WidgetState {
  Node<Widget>? head;
  bool canAct;
  int currentIndex;
  double scaleValue;

  _WidgetState({
    this.head,
    this.canAct = true,
    this.currentIndex = 0,
    this.scaleValue = 0,
  });
}

class _WidgetEvent {
  Node<Widget>? head;
  bool? canAct;
  int? currentIndex;
  double? scaleValue;

  _WidgetEvent({this.head, this.canAct, this.currentIndex, this.scaleValue});
}

class WidgetBloc extends Bloc<_WidgetEvent, _WidgetState> {
  WidgetBloc() : super(_WidgetState()) {
    on<_WidgetEvent>((event, emit) {
      emit(_WidgetState(
          head: event.head ?? state.head,
          canAct: event.canAct ?? state.canAct,
          currentIndex: event.currentIndex ?? state.currentIndex,
          scaleValue: event.scaleValue ?? state.scaleValue,
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

  static void open(BuildContext context)=> context.findAncestorStateOfType<WidgetTabScreenState>()?.animationController.forward();

  static void close(BuildContext context)=> context.findAncestorStateOfType<WidgetTabScreenState>()?.animationController.reverse();

  WidgetDrawer({required this.children, required this.header, this.width = 250, this.colorHeader, this.backGroundColor});
}
