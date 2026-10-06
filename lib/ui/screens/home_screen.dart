import 'package:drag_and_drop_game/core/utils/image_paths.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/ui/widgets/basic_button.dart';
import 'package:drag_and_drop_game/ui/widgets/image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _player = AudioService.instance();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppThemes.appBar,
      body: Container(
        height: .infinity,
        width: .infinity,
        padding: const .symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(gradient: AppThemes.gradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: <Widget>[
              Material(
                elevation: 10,
                shadowColor: AppThemes.white.withValues(alpha: 0.4),
                borderRadius: AppThemes.stdBorderRadius,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                    minHeight: 250
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: AppThemes.stdBorderRadius,
                      border: .all(color: AppThemes.white.withValues(alpha: 0.3)),
                    ),
                    child: const ImageWidget(
                      imagePath: ImagePaths.emojiConquestLogo,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FractionallySizedBox(
                widthFactor: 0.6,
                child: BasicButton(
                  play: _goSelectEmojiScreen,
                  screen: AppRoutes.selectEmojis,
                  text: "Jogar",
                ),
              ),
              TextButton(
                onPressed: () =>
                  _goRulesScreen(
                    context: context, 
                    screen: AppRoutes.rules
                  ),
                child: const Text(
                  "Como Jogar",
                  style: TextStyle(color: AppThemes.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goSelectEmojiScreen({required BuildContext context, required String screen}) {
    _player.play(audio: .button2);
    Navigator.pushReplacementNamed(context, screen);
  }

  void _goRulesScreen({required BuildContext context, required String screen}) {
    _player.play(audio: .button2);
    Navigator.pushNamed(context, screen);
  }
}
