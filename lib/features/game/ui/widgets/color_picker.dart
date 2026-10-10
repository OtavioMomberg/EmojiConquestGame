import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/color_tile.dart';

class const ColorPicker({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: <Widget>[
        ....generate(AppThemes.colorPicker.length, (index) {
          return ColorTile(color: AppThemes.colorPicker[index]);
        }),
      ],
    );
  }
}
