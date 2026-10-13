import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/data/field_model.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const Field({
  required final FieldModel field,
  super.key
}) extends StatefulWidget {
  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final _gameService = GameService.instance();

  @override
  Widget build(BuildContext context) {
    return DragTarget<PlayerModel>(
      builder: (_, item, _) {
        return AnimatedScale(
          scale: (item.isNotEmpty && !widget.field.isConquested) ? 1.05 : 1.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
          child: Card(
            color: widget.field.isConquested 
              ? AppColors.lightGray
              : AppColors.lightGray2,
            elevation: 5,
            shadowColor: widget.field.isConquested 
              ? AppColors.lightGray
              : AppColors.lightGray2,
            shape: RoundedRectangleBorder(
              borderRadius: AppThemes.stdBorderRadius,
            ),
            child: Center(
              child: Text(
                "X: ${widget.field.lifeX}\n\nY: ${widget.field.lifeY}",
                style: AppThemes.fieldTextStyle
              ),
            )
          )
        );
      },
      onAcceptWithDetails: (details) {  
        if (widget.field.isConquested) { return; }

        if (!widget.field.hasEmoji()) {
          widget.field.receiveDamage(
            attack: details.data.emoji.attack, 
            player: details.data.playerId
          );
          setState(() {});
          _gameService.blockSortButton.value = false;
          details.data.emoji.restoreOriginalAttack();
          _gameService.changeTurn();
        }
      }
    );
  }
}