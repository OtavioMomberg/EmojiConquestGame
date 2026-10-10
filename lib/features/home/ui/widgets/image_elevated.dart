import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/shared/widgets/image_rounded.dart';

class const ImageElevated({
  required final String imagePath,
  final double elevation = 10,
  final Color color = AppColors.white,
  final BorderRadius borderRadius = AppThemes.stdBorderRadius,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: color.withValues(alpha: 0.4),
      borderRadius: borderRadius,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300, 
          minHeight: 250
        ),
        child: DecoratedBox(
          position: .foreground,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: .all(color: color),
          ),
          child: ImageRounded(imagePath: imagePath)
        )
      )
    );
  }
}
