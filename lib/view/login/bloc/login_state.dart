part of 'login_bloc.dart';

class LoginState {
  double scaleValue;
  String validateEmail, validatePassword;
  bool isShowPass;

  LoginState({
    this.scaleValue = 1.0,
    this.validateEmail = "",
    this.validatePassword = "",
    this.isShowPass = false
  });
}

class LoadLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  SuccessLoginState() : super();
}