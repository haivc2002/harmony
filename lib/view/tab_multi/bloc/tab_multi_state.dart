part of 'tab_multi_bloc.dart';

class TabMultiState {
  Node<Widget>? head;
  bool canAct;
  int currentIndex;

  TabMultiState({this.head, this.canAct = true, this.currentIndex = 0});
}