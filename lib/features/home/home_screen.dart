import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/shared/widgets/border_button.dart';
import 'package:drag_and_drop_game/shared/widgets/formatted_container.dart';
import 'package:drag_and_drop_game/shared/widgets/button.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:drag_and_drop_game/core/utils/image_paths.dart';
import 'package:drag_and_drop_game/features/home/image_elevated.dart';

class const HomeScreen({super.key}) extends StatelessWidget with RouterScreens {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppThemes.appBar,
      backgroundColor: AppColors.darkGray,
      body: FormattedContainer(
        useSafeArea: true,
        child: Column(
          mainAxisAlignment: .center,
          children: <Widget>[
            FractionallySizedBox(
              widthFactor: .8,
              child: const ImageElevated(
                imagePath: ImagePaths.emojiConquestLogo
              ),
            ),
            const SizedBox(height: 40),
            FractionallySizedBox(
              widthFactor: .8,
              child: Button(
                onTap: () {
                  AudioHelper.instance().play(audio: .button2);
                  navigate(
                    context: context,
                    screen: AppRoutes.selectEmojis,
                    type: .pushReplacementNamed,
                  );
                },
                text: "Jogar",
              ),
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: .8,
              child: BorderButton(
                screen: AppRoutes.rules, 
                label: "Como Jogar"
              ),
            )
          ]
        )
      )
    );
  }
}