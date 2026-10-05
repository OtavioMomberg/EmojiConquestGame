import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const ImageWidget({
  required final String imagePath, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppThemes.stdBorderRadius,
      child: Image.asset(
        imagePath,
        fit: .contain,
        filterQuality: .high,
        colorBlendMode: .darken
      )
    );
  }
}