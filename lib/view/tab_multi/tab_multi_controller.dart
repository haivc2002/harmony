import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/home/home_screen.dart';
import 'package:harmony/view/tab_multi/bloc/tab_multi_bloc.dart';

import '../match/match_screen.dart';

class TabMultiController extends BaseController {
  TabMultiController(super.context);

  late PageController pageController;

  late final LinkList linkList = LinkList(context, pageController);

  List<Widget> listPage = [
    const HomeScreen(),
    CustomTabMultiDrawer(),
    Container(color: MyColor.white),
    Container(color: MyColor.red),
  ];

  @override
  void onInitState() {
    pageController = PageController();
    final state = context.read<TabMultiBloc>().state;
    if (listPage.isNotEmpty) linkList._addFirst(listPage[0], state);
    super.onInitState();
  }
}

class LinkList extends TabMultiController {
  final PageController _pageController;
  LinkList(super.context, this._pageController);

  final int _durationDefault = 300;

  void navigationHandling(int index, TabMultiState state) {
    if (!state.canAct || index == state.currentIndex) return;
    bool canAct = false;
    if (index < state.currentIndex) {
      _pageController.jumpToPage(1);
      _addFirst(listPage[index], state);
    } else if (index > state.currentIndex) {
      _addLast(listPage[index], state);
    }
    context.read<TabMultiBloc>().add(TabMultiEvent(currentIndex: index, canAct: canAct));
  }

  Future<void> _addFirst(Widget screen, TabMultiState state) async {
    Node<Widget> newNode = Node(screen);
    newNode.next = state.head;
    context.read<TabMultiBloc>().add(TabMultiEvent(head: newNode));
    if (_pageController.hasClients) {
      await _pageController.previousPage(
        duration: Duration(milliseconds: _durationDefault * 2),
        curve: Curves.ease,
      );
      Future.delayed(const Duration(milliseconds: 300), ()=> _removeLast());
    }
  }


  Future<void> _addLast(Widget data, TabMultiState state) async {
    Node<Widget> newNode = Node(data);
    if (state.head == null) {
      context.read<TabMultiBloc>().add(TabMultiEvent(head: newNode));
    } else {
      Node<Widget>? current = state.head;
      while (current!.next != null) {
        current = current.next;
      }
      current.next = newNode;
      context.read<TabMultiBloc>().add(TabMultiEvent(head: state.head));
    }
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: Duration(milliseconds: _durationDefault),
        curve: Curves.ease,
      ).whenComplete(() async {
        await Future.delayed(const Duration(milliseconds: 1));
        _removeFirst(state);
      });
    }
  }

  void _removeFirst(TabMultiState state) {
    if (state.head != null) {
      context.read<TabMultiBloc>().add(TabMultiEvent(head: state.head!.next, canAct: true));
    }
  }

  void _removeLast() {
    final state = context.read<TabMultiBloc>().state;
    if (state.head == null) return;
    if (state.head!.next == null) {
      context.read<TabMultiBloc>().add(TabMultiEvent(head: null, canAct: true));
    } else {
      Node<Widget>? current = state.head;
      while (current!.next!.next != null) {
        current = current.next;
      }
      current.next = null;
      context.read<TabMultiBloc>().add(TabMultiEvent(head: state.head, canAct: true));
    }
  }

  List<Widget> getList(TabMultiState state) {
    List<Widget> result = [];
    Node<Widget>? current = state.head;
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
}

class Node<Widget> {
  Widget data;
  Node<Widget>? next;

  Node(this.data);
}