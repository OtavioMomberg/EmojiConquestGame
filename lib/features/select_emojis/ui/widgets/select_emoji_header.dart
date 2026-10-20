import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/features/select_emojis/ui/widgets/help_button.dart';

class const SelectEmojiHeader({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      spacing: 10,
      mainAxisAlignment: .center,
      children: <Widget>[
        Text(
          "Escolha seus Emojis!",
          style: TextStyle(
            fontSize: 20,
            fontWeight: .bold,
            color: AppColors.white,
          ),
        ),
        HelpButton(),
      ],
    );
  }
}
