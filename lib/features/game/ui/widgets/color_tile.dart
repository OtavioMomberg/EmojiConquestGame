import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const ColorTile({
  required final Color color, 
  required final bool isSelected,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: .all(
          color: isSelected ? AppColors.orange : AppColors.white, 
          width: isSelected ? 4 : 2
        ),
        borderRadius: AppThemes.largerBorderRadius,
      ),
      child: Card(
        elevation: 10,
        shadowColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: AppThemes.largerBorderRadius,
        ),
        color: color,
      ),
    );
  }
}
