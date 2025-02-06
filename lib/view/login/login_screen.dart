import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:harmony/base_project/package_widget.dart';
import 'package:harmony/view/login/bloc/login_bloc.dart';
import 'package:harmony/view/login/login_controller.dart';
import 'package:harmony/widget/splash_animation.dart';

class LoginScreen extends BaseView<LoginController> {
  static const String router = "/LoginScreen";
  const LoginScreen({super.key});

  @override
  LoginController createController(BuildContext context) => LoginController(context);

  @override
  Widget build() {
    return SplashAnimation(
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return AnimatedScale(
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: const Duration(seconds: 1),
            scale: state.scaleValue,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Container(
                    height: Utilities.screen(context).h,
                    width: Utilities.screen(context).w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(MyImage.backgroundLogin),
                            fit: BoxFit.cover
                        )
                    ),
                    child: SizedBox(
                      height: Utilities.screen(context).h,
                      width: Utilities.screen(context).w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: GradientColor.blackBackgroundInLogin
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(height: Utilities.screen(context).h * 0.7),
                          WidgetButton(
                              styleText: Styles.def.setColor(MyColor.black.opacity6).bold,
                              color: MyColor.white,
                              radius: 100,
                              padding: EdgeInsets.symmetric(vertical: 12.w),
                              textButton: os.language.hasAccount,
                              onTap: () => controller.openLogin.perform(_bodyLogin())
                          ),
                          SizedBox(height: 20.w),
                          WidgetButton(
                              styleText: Styles.def.setColor(MyColor.white).bold,
                              color: MyColor.pink,
                              radius: 100,
                              textButton: os.language.notAccount,
                              onTap: () => controller.onChangeLanguage(Vi.language)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
          );
        }
      ),
    );
  }

  Widget _bodyLogin() {
    return Dialog(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Material(
          color: Colors.transparent,
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(end: 30, begin: 0),
                builder: (context, value, child) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: value, sigmaX: value),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(
                            os.language.titleLogin,
                            style: Styles.def.setColor(MyColor.white).bold.setTextSize(30.sp),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(child: Divider(color: MyColor.white.opacity5))
                        ]),
                        SizedBox(height: 30.w),
                        WidgetInput(
                          controller: controller.onLogin.emailController,
                          colorInput: MyColor.black.opacity3,
                          labelText: 'Email',
                          colorText: MyColor.white,
                          keyboardType: TextInputType.emailAddress,
                          validate: state.validateEmail,
                        ),
                        SizedBox(height: 20.w),
                        WidgetInput(
                          controller: controller.onLogin.passController,
                          hidePass: !state.isShowPass,
                          colorInput: MyColor.black.opacity3,
                          labelText: os.language.password,
                          colorText: MyColor.white,
                          keyboardType: TextInputType.visiblePassword,
                          validate: state.validatePassword,
                          suffixIcon: IconButton(
                            onPressed: ()=> controller.onShowPassWord.perform(state.isShowPass),
                            icon: Icon(state.isShowPass ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill, color: MyColor.white.opacity7)
                          ),
                        ),
                        SizedBox(height: 20.w),
                        WidgetButton(
                          textButton: os.language.titleLogin,
                          radius: 10.w,
                          color: MyColor.pink.opacity6,
                          styleText: Styles.def.setTextSize(15.sp).bold.setColor(MyColor.white),
                          onTap: ()=> controller.onLogin.perform(state, os)
                        ),
                        SizedBox(height: 20.w),
                        Row(children: [
                          Expanded(child: Divider(endIndent: 20.w, color: MyColor.white.opacity5)),
                          Text(os.language.or, style: Styles.def.whiteText),
                          Expanded(child: Divider(indent: 20.w, color: MyColor.white.opacity5)),
                        ]),
                        GestureDetector(
                          onTap: controller.onLoginWithGoogle.perform,
                          child: Container(
                            height: 30.w,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: MyColor.white,
                              borderRadius: BorderRadius.circular(6.w),
                            ),
                            margin: EdgeInsets.only(top: 20.w),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 30.w,
                                  width: 30.w,
                                  child: Image.asset(MyImage.iconGoogle),
                                ),
                                Expanded(child: Center(child: Text("Google", style: Styles.def.bold.setColor(MyColor.black.opacity7)))),
                                SizedBox(height: 30.w, width: 30.w),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}
