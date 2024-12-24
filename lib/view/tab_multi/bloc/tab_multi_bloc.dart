import 'package:harmony/view/tab_multi/tab_multi_controller.dart';

import '../../../base_project/package_widget.dart';

part 'tab_multi_event.dart';
part 'tab_multi_state.dart';

class TabMultiBloc extends Bloc<TabMultiEvent, TabMultiState> {
  TabMultiBloc() : super(TabMultiState()) {
    on<TabMultiEvent>((event, emit) {
      emit(TabMultiState(
        head: event.head ?? state.head,
        canAct: event.canAct ?? state.canAct,
        currentIndex: event.currentIndex ?? state.currentIndex
      ));
    });
  }
}

