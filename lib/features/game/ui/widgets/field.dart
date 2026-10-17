import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/emoji_bottom_sheet.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/features/game/data/field_model.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';

class const Field({required final FieldModel field, super.key})
    extends StatefulWidget {
  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final _gameService = GameService.instance();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppThemes.stdBorderRadius,
      onTap: () => _selectEmojiToField(player: _gameService.getPlayer()),
      child: DragTarget<PlayerModel>(
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
                    Text(
                      widget.field.emoji.emoji, 
                      style: const TextStyle(fontSize: 18)
                    ),
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
            if (widget.field.emojiOwner == details.data.playerId) { 
              _attackWitoutEmoji(player: details.data);
             } else {
              _attackWithEmoji(player: details.data);
             }
          }
          _completeEmojiTurn();
          setState(() {});
          _gameService.changePlayerInTurn();
        },
      ),
    );
  }

  void _selectEmojiToField({required PlayerModel player}) async {
    final emojiIndex = await showModalBottomSheet<int>(
      backgroundColor: AppColors.darkGray,
      isScrollControlled: true,
      context: context,
      builder: (context) => SafeArea(
        child: EmojiBottomSheet(player: player)
      ),
    );

    if (emojiIndex == null) { return; }
    widget.field.placeEmoji(
      emoji: player.emojis[emojiIndex], 
      player: player.playerId
    );

    player.removeEmoji(emoji: player.emojis[emojiIndex]);
    setState(() {});
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
      player.removeEmoji(emoji: player.emoji);
    }
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