import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/ui/widgets/image.dart';

class const ImageElevated({
  required final String path,
  final double elevation = 10,
  final Color color = AppThemes.white,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: color.withValues(alpha: 0.4),
      borderRadius: AppThemes.stdBorderRadius,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 300, 
          minHeight: 250
        ),
        child: DecoratedBox(
          position: .foreground,
          decoration: BoxDecoration(
            borderRadius: AppThemes.stdBorderRadius,
            border: .all(color: color),
          ),
          child: ImageWidget(imagePath: path),
        ),
      ),
    );
  }
}