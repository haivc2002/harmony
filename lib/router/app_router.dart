
import 'package:flutter/cupertino.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.router:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
        
    case HomeScreen.router:
        return CupertinoPageRoute(builder: (_) => const HomeScreen());

      default:
        return null;
    }
  }
}