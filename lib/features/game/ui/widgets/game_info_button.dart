import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const GameInfoButton({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.blue,
      borderRadius: AppThemes.largerBorderRadius,
      child: InkWell(
        borderRadius: AppThemes.largerBorderRadius,
        onTap: () {},
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 45, 
            minHeight: 20
          ),
          child: const Icon(
            Icons.help_outline, 
            color: AppColors.white
          ),
        ),
      ),
    );
  }
}
