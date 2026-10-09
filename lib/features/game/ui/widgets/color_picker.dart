import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/data/colors.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/color_option.dart';

class const ColorPicker({
  required final ColorsModel colorsModel, 
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: <Widget>[
        ....generate(colorsModel.selectedColor.length, (index) {
          return ColorOption(
            index: index,
            cor: colorsModel.colorPickerColors[index],
            selectedColor: colorsModel.selectedColor[index],
          );
        })
      ]
    );
  }
}
