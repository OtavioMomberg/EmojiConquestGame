import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class ColorOption extends StatelessWidget {
  final int index;
  final Color cor;
  final bool selectedColor;

  const ColorOption({
    required this.index,
    required this.cor,
    required this.selectedColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        border: .all(
          color: selectedColor 
            ? AppThemes.orange 
            : AppThemes.blue,
          width: 2
        ),
        borderRadius: AppThemes.largerBorderRadius
      ),
      child: Card(
        elevation: 10,
        shadowColor: cor.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: AppThemes.largerBorderRadius
        ),
        color: cor
      )
    );
  }
}