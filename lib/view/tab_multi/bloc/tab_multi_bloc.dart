import '../../../base_project/package_widget.dart';

part 'tab_multi_event.dart';
part 'tab_multi_state.dart';

class TabMultiBloc extends Bloc<TabMultiEvent, TabMultiState> {
  TabMultiBloc() : super(TabMultiState()) {
    on<TabMultiEvent>((event, emit) {
      emit(TabMultiState(isDark: event.isDark ?? state.isDark));
    });
  }
}

