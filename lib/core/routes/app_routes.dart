import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/models/game_screen_data.dart';
import 'package:drag_and_drop_game/ui/screens/export_screens.dart';

final class AppRoutes._() {
  static const home = "/";
  static const rules = "/rules";
  static const selectEmojis = "/select_emojis";
  static const game = "/game";

  static Widget _getScreen({required RouteSettings settings}) {
    switch (settings.name) {
      case home:
        return HomeScreen();
      case selectEmojis:
        return const SelectEmojisScreen();
      case rules:
        return const RulesScreen();
      case game:
        final arguments = settings.arguments as GameScreenData;
        return GameScreen(playersData: arguments);
    }
    return HomeScreen();
  }

  static Route<dynamic> getRoute(RouteSettings settings) {
    final screen = _getScreen(settings: settings);

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, _, _) => screen,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end)
          .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween), 
          child: child
        );
      }
    );
  }
}