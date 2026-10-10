import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/shared/widgets/button.dart';
import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:drag_and_drop_game/core/utils/image_paths.dart';
import 'package:drag_and_drop_game/features/home/ui/widgets/image_elevated.dart';

class HomeScreen extends StatelessWidget with RouterScreens {
  new({super.key});

  final _player = AudioHelper.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        useSafeArea: true,
        child: Column(
          mainAxisAlignment: .spaceEvenly,
          children: <Widget>[
            const ImageElevated(imagePath: ImagePaths.emojiConquestLogo),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.6,
              child: Button(
                onTap: () {
                  _player.play(audio: .button2);
                  navigate(
                    context: context,
                    screen: AppRoutes.selectEmojis,
                    type: .pushReplacementNamed,
                  );
                },
                text: "Jogar",
              ),
            ),
            TextButton(
              onPressed: () {
                _player.play(audio: .button2);
                navigate(context: context, screen: AppRoutes.rules);
              },
              child: const Text(
                "Como Jogar",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}