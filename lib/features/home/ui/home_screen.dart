import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/core/utils/image_paths.dart';
import 'package:drag_and_drop_game/features/home/ui/widgets/image_elevated.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/routes/app_routes.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/widgets/basic_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _player = AudioService.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppThemes.darkGray,
      body: FormattedContainer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: <Widget>[
              const ImageElevated(path: ImagePaths.emojiConquestLogo),
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