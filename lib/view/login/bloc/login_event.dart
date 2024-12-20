part of 'login_bloc.dart';

class LoginEvent {
  double? scaleValue;
  String? validateEmail, validatePassword;
  bool? isShowPass;

  LoginEvent({this.scaleValue, this.validateEmail, this.validatePassword, this.isShowPass});
}