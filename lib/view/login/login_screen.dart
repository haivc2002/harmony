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
  LoginController controller(BuildContext context) => LoginController(context);

  @override
  Widget build(context, system, controller) {
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
                    height: Common.screen(context, be: Be.height),
                    width: Common.screen(context, be: Be.width),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(MyImage.backgroundLogin),
                            fit: BoxFit.cover
                        )
                    ),
                    child: SizedBox(
                      height: Common.screen(context, be: Be.height),
                      width: Common.screen(context, be: Be.width),
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
                          SizedBox(height: Common.screen(context, be: Be.height) * 0.7),
                          WidgetButton(
                              styleText: Styles.def.setColor(MyColor.black.withOpacity(0.6)).bold,
                              color: MyColor.white,
                              radius: 100,
                              padding: EdgeInsets.symmetric(vertical: 12.w),
                              textButton: system.language.hasAccount,
                              onTap: () => controller.openLogin.perform(_bodyLogin(context, system, controller))
                          ),
                          SizedBox(height: 20.w),
                          WidgetButton(
                              styleText: Styles.def.setColor(MyColor.white).bold,
                              color: MyColor.pink,
                              radius: 100,
                              textButton: system.language.notAccount,
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

  Widget _bodyLogin(BuildContext context, BaseState system, LoginController controller) {
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
                            system.language.titleLogin,
                            style: Styles.def.setColor(MyColor.white).bold.setTextSize(30.sp),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(child: Divider(color: MyColor.white.withOpacity(0.5)))
                        ]),
                        SizedBox(height: 30.w),
                        WidgetInput(
                          controller: controller.onLogin.emailController,
                          colorInput: MyColor.black.withOpacity(0.3),
                          labelText: 'Email',
                          colorText: MyColor.white,
                          keyboardType: TextInputType.emailAddress,
                          validate: state.validateEmail,
                        ),
                        SizedBox(height: 20.w),
                        WidgetInput(
                          controller: controller.onLogin.passController,
                          hidePass: !state.isShowPass,
                          colorInput: MyColor.black.withOpacity(0.3),
                          labelText: system.language.password,
                          colorText: MyColor.white,
                          keyboardType: TextInputType.visiblePassword,
                          validate: state.validatePassword,
                          suffixIcon: IconButton(
                            onPressed: ()=> controller.onShowPassWord.perform(state.isShowPass),
                            icon: Icon(state.isShowPass ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill, color: MyColor.white.withOpacity(0.7))
                          ),
                        ),
                        SizedBox(height: 20.w),
                        WidgetButton(
                          textButton: system.language.titleLogin,
                          radius: 10.w,
                          color: MyColor.pink.withOpacity(0.6),
                          styleText: Styles.def.setTextSize(15.sp).bold.setColor(MyColor.white),
                          onTap: ()=> controller.onLogin.perform(state, system)
                        ),
                        SizedBox(height: 20.w),
                        Row(children: [
                          Expanded(child: Divider(endIndent: 20.w, color: MyColor.white.withOpacity(0.5))),
                          Text(system.language.or, style: Styles.def.whiteText),
                          Expanded(child: Divider(indent: 20.w, color: MyColor.white.withOpacity(0.5))),
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
                                Expanded(child: Center(child: Text("Google", style: Styles.def.bold.setColor(MyColor.black.withOpacity(0.7))))),
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
