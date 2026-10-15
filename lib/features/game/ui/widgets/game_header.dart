import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const GameHeader({
  required final String turn,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Turno: $turn",
      style: AppThemes.fieldTextStyle.copyWith(
        fontSize: 25
      )
    );
  }
}
