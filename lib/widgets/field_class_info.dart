import 'package:drag_and_drop_game/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class FieldClassInfo extends StatelessWidget {
  final void Function(int) seeInfo;
  final int imageIndex;
  const FieldClassInfo({required this.seeInfo, required this.imageIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppThemes.blue,
      borderRadius: AppThemes.largerBorderRadius,
      child: InkWell(
        borderRadius: AppThemes.largerBorderRadius,
        onTap: () => seeInfo(imageIndex),
        child: Icon(
          Icons.help_outline, 
          color: AppThemes.white
            .withValues(alpha: 0.7)
        ),
      )
    );
  }
}