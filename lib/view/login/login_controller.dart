
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/login/bloc/login_bloc.dart';
import 'package:harmony/view/tab_multi/tab_multi_screen.dart';

import '../../model/response/model_info_user.dart';

final class LoginController extends BaseController with Repository {
  LoginController(super.context);

  late final OpenLogin openLogin = OpenLogin(this);
  late final OnLogin onLogin = OnLogin(this);
  late final OnLoginWithGoogle onLoginWithGoogle = OnLoginWithGoogle(this);
  late final OnShowPassWord onShowPassWord = OnShowPassWord(this);
}

base class OpenLogin {
  final LoginController _controller;
  OpenLogin(this._controller);

  void perform(Widget child) {
    _controller.context.read<LoginBloc>().add(LoginEvent(scaleValue: 1.1));
    showCupertinoDialog(
      context: _controller.context,
      barrierDismissible: true,
      builder: (context) => child
    ).whenComplete(() {
      if(_controller.context.mounted) _controller.context.read<LoginBloc>().add(LoginEvent(scaleValue: 1.0));
    });
  }
}

class OnLogin {
  final LoginController _controller;
  OnLogin(this._controller);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _check(LoginState state, BaseState system) {
    state.validateEmail = emailController.text.isEmpty ? system.language.emailEmpty : "";
    state.validatePassword = passController.text.isEmpty ? system.language.passwordEmpty : "";
    _controller.context.read<LoginBloc>().add(LoginEvent(
        validateEmail: state.validateEmail,
        validatePassword: state.validatePassword
    ));
    return state.validateEmail.isEmpty && state.validatePassword.isEmpty;
  }

  void perform(LoginState state, BaseState system) async {
    if(_check(state, system)) {
      Utilities.onLoading(_controller.context);
      final response = await _controller.postLogin(emailController.text, passController.text);
      if(response is Success<ModelInfoUser>) {
        response.value.result == 0 ? _toNextPage() : _toError(response.value.message!);
      } else if(response is Failure<ModelInfoUser>) {
        _toError(response.errorCode);
      }
    }
  }

  void _toNextPage() {
    Utilities.onHideLoad(_controller.context);
    Navigator.pushNamedAndRemoveUntil(_controller.context, TabMultiScreen.router, (route) => false);
  }

  void _toError(Object code) {
    Utilities.onHideLoad(_controller.context);
    Utilities.popupError(_controller.context, code: code);
    // Utilities.popupError(_controller.context, title: title);
  }
}

class OnLoginWithGoogle {
  final LoginController _controller;
  OnLoginWithGoogle(this._controller);

  final firebaseAuth = FirebaseAuth.instance;

  Future<void> perform() async {
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) await googleSignIn.signOut();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;
    final cred = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken,
    );
    await firebaseAuth.signInWithCredential(cred);
    // final response  = await _controller.postLoginWithGoogle(firebaseAuth.currentUser?.email);
    // if(response is Success<ModelInfoUser, Exception>) {
    //   if(response.value.result == 'Success') {
    //
    //   }
    // } else if(response is Failure<ModelInfoUser, Exception>) {
    //   print(response.exception);
    // }
  }
}

class OnShowPassWord {
  final LoginController _controller;
  OnShowPassWord(this._controller);

  void perform(bool isShowPass) {
    isShowPass = !isShowPass;
    _controller.context.read<LoginBloc>().add(LoginEvent(isShowPass: isShowPass));
  }
}

