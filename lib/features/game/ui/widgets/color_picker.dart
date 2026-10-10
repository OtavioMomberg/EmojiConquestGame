import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/color_tile.dart';

class const ColorPicker({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: <Widget>[
        ....generate(4, (index) {
          return ColorTile();
        }),
      ],
    );
  }
}
