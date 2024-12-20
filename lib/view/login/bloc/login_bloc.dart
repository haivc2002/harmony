
import 'package:harmony/base_project/package_widget.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvent>((event, emit) {
      emit(LoginState(
        scaleValue: event.scaleValue ?? state.scaleValue,
        validateEmail: event.validateEmail ?? state.validateEmail,
        validatePassword: event.validatePassword ?? state.validatePassword,
        isShowPass: event.isShowPass ?? state.isShowPass
      ));
    });
  }
}