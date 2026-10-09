import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const FieldClassInfo({
  required final VoidCallback showHierarchy,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppThemes.blue,
      borderRadius: AppThemes.largerBorderRadius,
      child: InkWell(
        borderRadius: AppThemes.largerBorderRadius,
        onTap: showHierarchy,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 45,
            minHeight: 20
          ),
          child: const Icon(
            Icons.help_outline,
            color: AppThemes.white,
          ),
        ),
      ),
    );
  }
}
