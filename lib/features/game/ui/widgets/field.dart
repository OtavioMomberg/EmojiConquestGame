import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:drag_and_drop_game/features/game/domain/game_service.dart';
import 'package:drag_and_drop_game/features/game/ui/widgets/emoji_bottom_sheet.dart';
import 'package:drag_and_drop_game/features/game/data/field_model.dart';
import 'package:drag_and_drop_game/features/game/data/player_model.dart';

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
      onTap: () {
        if (_gameService.validadePlayerBeforeSelectEmoji(field: widget.field)) {
          _selectEmojiToField(player: _gameService.getCurrentPlayer());
        }
      },
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
              child: ValueListenableBuilder(
                valueListenable: widget.field.emojiDisplay,
                builder: (_, emoji, _) {
                  return Column(
                    mainAxisAlignment: .center,
                    children: <Widget>[
                      if (widget.field.hasEmoji()) ...[
                        Text(
                          "X: ${widget.field.lifeX} | "
                          "Y: ${widget.field.lifeY}",
                          style: AppThemes.fieldTextStyle,
                        ),
                        Text(
                          "$emoji ${widget.field.emoji.attack}", 
                          style: TextStyle(
                            fontSize: 30, 
                            color: item.isNotEmpty 
                              ? _playerAttack(player: item.first!) > widget.field.emoji.attack 
                                ? AppColors.blue 
                                : _playerAttack(player: item.first!) == widget.field.emoji.attack 
                                  ? AppColors.white : AppColors.red
                              : AppColors.white
                          )
                        ),
                      ] else ...[
                        Text(
                          "X: ${widget.field.lifeX}\n"
                          "Y: ${widget.field.lifeY}\n",
                          style: AppThemes.fieldTextStyle,
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          );
        },
        onAcceptWithDetails: (details) {
          if (widget.field.isConquested) { return; }
          _gameService.audioPlayer.play(audio: .placement);

          final checkEmojiOwner = widget.field.emojiOwner == details.data.playerId;

          if (!widget.field.hasEmoji() || checkEmojiOwner) {
            _gameService.attackWitoutEmoji(
              player: details.data,
              field: widget.field,
            );
          } else {
            _gameService.attackWithEmoji(
              player: details.data,
              field: widget.field,
            );
          }
          setState(() {});
          _gameService..completeTurn()..changePlayerInTurn();
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
      player: player.playerId,
    );

    player..changeEmojiInField()
      ..removeEmoji(emoji: player.emojis[emojiIndex]);
  }

  int _playerAttack({required PlayerModel player}) {
    if (widget.field.hasEmoji()) {
      return player.emoji.displayAdjustedAttack(
        defenseEmoji: widget.field.emoji.emojiType
      );
    }
    return player.emoji.attack;
  }
}