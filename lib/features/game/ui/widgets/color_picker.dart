import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:drag_and_drop_game/core/config_export.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/color_tile.dart';

class const ColorPicker({
  required final GameService gameService,
  super.key
}) extends StatefulWidget {
  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.gameService.selectedColor,
      builder: (_, isSelected, _) {
        return Row(
          mainAxisAlignment: .spaceEvenly,
          children: <Widget>[
            ....generate(AppThemes.colorPicker.length, (index) {
              return ColorTile(
                color: AppThemes.colorPicker[index],
                isSelected: isSelected[index],
              );
            }),
          ],
        );
      }
    );
  }
}
