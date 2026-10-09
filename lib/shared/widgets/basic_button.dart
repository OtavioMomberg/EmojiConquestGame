import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

typedef Navigate = void Function({
  required BuildContext context, 
  required String screen
});

class const BasicButton({ 
  required final Navigate play,
  required final String screen,
  required final String text,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: AppThemes.white.withValues(alpha: 0.3),
      color: AppThemes.white,
      borderRadius: AppThemes.stdBorderRadius,
      surfaceTintColor: Colors.transparent,
      child: InkWell(
        borderRadius: AppThemes.stdBorderRadius,
        splashColor: AppThemes.lightGray2,
        onTap: () => play(context: context, screen: screen),
        child: SizedBox(
          height: 60,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: .bold,
                color: AppThemes.darkBlue.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
