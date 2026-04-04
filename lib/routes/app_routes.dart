import 'package:flutter/material.dart';
import 'package:drag_and_drop_game/models/game_page_args.dart';
import 'package:drag_and_drop_game/pages/choose_emoji_page.dart';
import 'package:drag_and_drop_game/pages/game_page.dart';
import 'package:drag_and_drop_game/pages/home_page.dart';
import 'package:drag_and_drop_game/pages/how_to_play_page.dart';


class AppRoutes {
  static const home = "/";
  static const howToPlay = "/how_to_play";
  static const chooseEmoji = "/choose_emoji";
  static const game = "/game";

  static Route<dynamic> dynamicRoute(RouteSettings settings) {
    Widget? page;

    switch(settings.name) {
      case home:
        page = const HomePage();
        break;
      case chooseEmoji:
        page = const ChooseEmojiPage();
        break;
      case howToPlay:
        page = const HowToPlayPage();
        break;
      case game:
        final args = settings.arguments as GamePageArgs;
        page = GamePage(ars: args);
        break;
    }
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, _, _) => page!,
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(1.0, 0.0); 
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            
        return SlideTransition(
          position: animation.drive(tween),
          child: child
        );
      },
    );
  }
}