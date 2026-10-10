import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const Button({
  required final String text,
  required final VoidCallback onTap,
  final double height = 60,
  final Color color = AppColors.white,
  final Color txtColor = AppColors.darkBlue,
  final Color splash = AppColors.lightGray2,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      elevation: 10,
      shadowColor: color.withValues(alpha: 0.3),
      borderRadius: AppThemes.stdBorderRadius,
      child: InkWell(
        borderRadius: AppThemes.stdBorderRadius,
        splashColor: splash,
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: .bold,
                color: txtColor.withValues(alpha: 0.8)
              )
            )
          )
        )
      )
    );
  }
}
