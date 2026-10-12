import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const DraggableEmoji({
  required final Color color,
  required final PlayerModel player,
  super.key
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Draggable<PlayerModel>(
      data: player,
      feedback: _PlayerTile(
        color: color,
        child: Text(
          "${player.emoji.emoji}\n"
          "${player.emoji.attack}",
          textAlign: .center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: .bold,
            color: AppColors.white,
          ),
        ),
      ),
      childWhenDragging: const _PlayerTile(
        color: AppColors.gray,
        dimension: 80,
      ),
      child: _PlayerTile(
        color: color,
        dimension: 80,
        child: Text(
          "Emoji",
          style: const TextStyle(
            fontWeight: .bold,
            color:AppColors.white
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
      shadowColor: color,
      child: SizedBox.square(
        dimension: dimension,
        child: Center(child: child)
      ),
    );
  }
}