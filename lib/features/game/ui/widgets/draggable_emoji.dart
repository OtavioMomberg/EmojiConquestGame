import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';

class const DraggableEmoji({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Draggable(
        feedback: _PlayerTile(
          color: AppThemes.blue,
          child: Text(
            "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: .bold,
              color: AppThemes.white,
            ),
          ),
        ),
        childWhenDragging: const _PlayerTile(
          color: AppThemes.gray,
          dimension: 80,
        ),
        child: _PlayerTile(
          color: AppThemes.blue,
          child: Text(
            "Emoji",
            style: const TextStyle(
              fontWeight: .bold,
              color:AppThemes.white
            ),
          ),
        ),
      ),
    );
  }
}

class const _PlayerTile({
  required final Color color,
  final double dimension = 100,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const StarBorder.polygon(
        sides: 8, 
        pointRounding: 0.3
      ),
      elevation: 8,
      child: SizedBox.square(
        dimension: dimension,
        child: Center(child: child)
      ),
    );
  }
}