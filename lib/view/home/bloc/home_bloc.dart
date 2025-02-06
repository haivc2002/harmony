
import 'package:harmony/base_project/package_widget.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {
      emit(HomeState(
        currentIndex: event.currentIndex,
        isShowNameHuman: event.isShowNameHuman ?? state.isShowNameHuman
      ));
    });
  }
}