import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/data/game_initial_data.dart';
import 'package:drag_and_drop_game/features/export_screens.dart';

enum TransitionType { slide, fade, scale }

final class const AppRoutes._() {
  static const home = "/";
  static const rules = "/rules";
  static const selectEmojis = "/select_emojis";
  static const game = "/game";

  static Widget _getTranslation({
  required Animation<double> animation, 
  required Widget child,
  required TransitionType type
  }) {
    switch (type) {
      case .slide:
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        final tween = Tween(
          begin: begin, 
          end: end
        ).chain(
          CurveTween(curve: curve)
        );

        return SlideTransition(
          position: animation.drive(tween), 
          child: child
        );
      case .fade:
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation, 
            curve: Curves.easeInOut
          ),
          child: child,
        );
      case .scale:
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation, 
            curve: Curves.easeInOut
          ),
          child: child,
        );
    }
  }

  static Widget _getScreen({required RouteSettings settings}) {
    switch (settings.name) {
      case home:
        return HomeScreen();
      case selectEmojis:
        return const SelectEmojisScreen();
      case rules:
        return const RulesScreen();
      case game:
        final arguments = settings.arguments as GameInitialData;
        return GameScreen(playersData: arguments);
      default:
        return HomeScreen();
    }
  }

  static Route<dynamic> getRoute(RouteSettings settings) {
    final screen = _getScreen(settings: settings);

     final transition = switch (settings.name) {
      home => TransitionType.fade,
      rules => TransitionType.slide,
      selectEmojis => TransitionType.slide,
      game => TransitionType.scale,
      _ => TransitionType.fade,
    };

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, _, _) => screen,
      transitionDuration: const Duration(milliseconds: 350),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, _, child) {
        return _getTranslation(
          animation: animation, 
          child: child, 
          type: transition
        );
      }
    );
  }
}