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
              : AppColors.grayBluish.withValues(alpha: .8),
            elevation: 5,
            shadowColor: widget.field.isConquested
              ? AppColors.lightGray
              : AppColors.grayBluish,
            shape: RoundedRectangleBorder(
              borderRadius: AppThemes.stdBorderRadius,
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: <Widget>[
                Text(
                  "X: ${widget.field.lifeX}\n"
                  "Y: ${widget.field.lifeY}\n",
                  style: AppThemes.fieldTextStyle,
                ),
                if (widget.field.hasEmoji()) ...[
                  Text(widget.field.emoji.emoji),
                ],
              ],
            ),
          ),
        );
      },
      onAcceptWithDetails: (details) {
        if (widget.field.isConquested) { return; }
        _gameService.audioPlayer.play(audio: .placement);

        if (!widget.field.hasEmoji()) {
          _attackWitoutEmoji(player: details.data);
        } else {
          _attackWithEmoji(player: details.data);
        }
        setState(() {});
        _gameService.changePlayerInTurn();
      },
    );
  }

  void _attackWitoutEmoji({required PlayerModel player}) {
    widget.field.receiveDamage(
      attack: player.emoji.attack,
      player: player.playerId,
    );
  }

  void _attackWithEmoji({required PlayerModel player}) {
    player.emoji.adjustClassAttack(defenseEmoji: widget.field.emoji.emojiType);

    if (player.emoji.attack > widget.field.emoji.attack) {
      final _ = widget.field.removeEmoji();
    } else if (player.emoji.attack < widget.field.emoji.attack) {
      player.removeEmoji();
    }
    _completeEmojiTurn();
  }

  void _completeEmojiTurn() {
    final checkFieldEmoji = _gameService.completeTurn(field: widget.field);

    if (checkFieldEmoji == null) { return; }

    if (widget.field.emojiOwner == _gameService.player1.playerId) {
      _gameService.player1.addEmoji(emoji: checkFieldEmoji);
      return;
    }
    if (widget.field.emojiOwner == _gameService.player2.playerId) {
      _gameService.player2.addEmoji(emoji: checkFieldEmoji);
    }
  }
}