import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const ImageRounded({
  required final String imagePath,
  final BorderRadius borderRadius = AppThemes.stdBorderRadius,
  final BoxFit fit = .contain,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        imagePath,
        fit: fit,
        filterQuality: .high,
        colorBlendMode: .darken,
      ),
    );
  }
}
