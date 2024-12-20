
import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/home/home_screen.dart';
import 'package:harmony/view/login/bloc/login_bloc.dart';

import '../../model/response/model_info_user.dart';

class LoginController extends BaseController with Repository {
  LoginController(super.context);

  late final OpenLogin openLogin = OpenLogin(context);
  late final OnLogin onLogin = OnLogin(context);
  late final OnLoginWithGoogle onLoginWithGoogle = OnLoginWithGoogle(context);
  late final OnShowPassWord onShowPassWord = OnShowPassWord(context);
}

class OpenLogin extends LoginController {
  OpenLogin(super.context);

  void perform(Widget child) {
    context.read<LoginBloc>().add(LoginEvent(scaleValue: 1.1));
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => child
    ).whenComplete(() {
      if(context.mounted) context.read<LoginBloc>().add(LoginEvent(scaleValue: 1.0));
    });
  }
}

class OnLogin extends LoginController {
  OnLogin(super.context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _check(LoginState state, BaseState system) {
    state.validateEmail = emailController.text.isEmpty ? system.language.emailEmpty : "";
    state.validatePassword = passController.text.isEmpty ? system.language.passwordEmpty : "";
    context.read<LoginBloc>().add(LoginEvent(validateEmail: state.validateEmail, validatePassword: state.validatePassword));
    return state.validateEmail.isEmpty && state.validatePassword.isEmpty;
  }

  void perform(LoginState state, BaseState system) async {
    Navigator.pushNamed(context, HomeScreen.router);
    // Common.popupError(context);
    // if(_check(state, system)) {
    //   final response = await postLogin(emailController.text, passController.text);
    // }
  }
}

class OnLoginWithGoogle extends LoginController {
  OnLoginWithGoogle(super.context);

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
    final response  = await postLoginWithGoogle(firebaseAuth.currentUser?.email);
    if(response is Success<ModelInfoUser, Exception>) {
      if(response.value.result == 'Success') {

      }
    }
    // if(response.result == "Success") {
    //   onSuccess();
    // } else {
    //   onError();
    // }
  }
}

class OnShowPassWord extends LoginController {
  OnShowPassWord(super.context);

  void perform(bool isShowPass) {
    isShowPass = !isShowPass;
    context.read<LoginBloc>().add(LoginEvent(isShowPass: isShowPass));
  }
}

