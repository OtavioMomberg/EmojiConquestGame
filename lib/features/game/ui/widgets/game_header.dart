import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/game_info_button.dart';

class const GameHeader({
  required final String turn,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceAround,
      spacing: 10,
      children: <Widget>[
        Text(
          "Turno: $turn",
          style: AppThemes.fieldTextStyle.copyWith(
            fontSize: 20
          )
        ),
        GameInfoButton()
      ]
    );
  }
}
