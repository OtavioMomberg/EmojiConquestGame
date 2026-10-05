import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/audio_services/audio_helper.dart';
import 'package:drag_and_drop_game/routes/app_routes.dart';
import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:drag_and_drop_game/widgets/basic_button.dart';
import 'package:drag_and_drop_game/widgets/image.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final player = AudioService.instance();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemes.lightGray,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const .symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(gradient: AppThemes.gradient),
        child: Column(
          mainAxisAlignment: .spaceEvenly,
          children: <Widget>[
            Material(
              elevation: 10,
              shadowColor: AppThemes.white.withValues(alpha: 0.4),
              borderRadius: AppThemes.stdBorderRadius,
              child: Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: AppThemes.stdBorderRadius,
                  border: .all(color: AppThemes.white.withValues(alpha: 0.3)),
                ),
                child: const ImageWidget(
                  imagePath: "assets/images/emoji_conquest_logo.png",
                ),
              ),
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: BasicButton(
                play: goNextPage,
                screen: AppRoutes.selectEmojis,
                text: "Jogar",
              ),
            ),
            TextButton(
              onPressed: () =>
                goNextPage(
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
    );
  }

  void goNextPage({required BuildContext context, required String screen}) {
    player.play(audio: .button1);
    Navigator.pushReplacementNamed(context, screen);
  }
}
