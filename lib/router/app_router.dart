
import 'package:flutter/cupertino.dart';
import 'package:harmony/view/tab_multi/tab_multi_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.router:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
        
      case HomeScreen.router:
          return CupertinoPageRoute(builder: (_) => const HomeScreen());

      case TabMultiScreen.router:
        return CupertinoPageRoute(builder: (_) => const TabMultiScreen());

      default:
        return null;
    }
  }
}