import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/routes/router.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';

class const BorderButton({
  required final String screen,
  required final String label,
  super.key
}) extends StatelessWidget with RouterScreens {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: AppThemes.stdBorderRadius,
          side: BorderSide(color: AppColors.white),
        ),
      ),
      onPressed: () {
        AudioHelper.instance().play(audio: .button2);
        navigate(context: context, screen: screen);
      },
      child: Text(
        label, 
        style: const TextStyle(
          color: AppColors.white
        )
      ),
    );
  }
}