
import 'package:flutter/cupertino.dart';
import 'package:harmony/view/tab_multi/tab_multi_screen.dart';
import '../view/explorer/explorer_screen.dart';
import '../view/home/home_screen.dart';
import '../view/login/login_screen.dart';
import '../view/match/match_screen.dart';
import '../view/message/message_screen.dart';
import '../view/message_view/message_view_screen.dart';
import '../view/profile/profile_screen.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const LoginScreen()
        );
        
      case HomeScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const HomeScreen()
        );

      case TabMultiScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const TabMultiScreen()
        );

      case MatchScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const MatchScreen()
        );

      case MessageScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const MessageScreen()
        );

      case ProfileScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const ProfileScreen()
        );

      case MessageViewScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const MessageViewScreen()
        );

      case ExplorerScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const ExplorerScreen()
        );

      default:
        return null;
    }
  }
}