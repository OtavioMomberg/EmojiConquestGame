import 'package:drag_and_drop_game/core/themes/app_themes.dart';
import 'package:material_ui/material_ui.dart';
import 'package:drag_and_drop_game/core/utils/audio_helper.dart';
import 'package:drag_and_drop_game/models/emoji.dart';
import 'package:drag_and_drop_game/models/emoji_data.dart';
import 'package:drag_and_drop_game/models/field.dart';
import 'package:drag_and_drop_game/models/player.dart';

class ConquestArea extends StatefulWidget {
  final AudioService player;
  final void Function([String?]) updateGameTurn;
  final void Function({required int index, bool? removeAttacker}) removeDefenseEmoji;
  final String Function() getDefenseEmojiOwner;
  final Color initialColor;
  final int fieldIndex;
  final EmojiData? defenseEmoji;

  const ConquestArea({
    required this.player,
    required this.updateGameTurn,
    required this.removeDefenseEmoji,
    required this.getDefenseEmojiOwner,
    required this.initialColor,
    required this.fieldIndex,
    this.defenseEmoji,
    super.key,
  });

  @override
  State<ConquestArea> createState() => _ConquestAreaState();
}

class _ConquestAreaState extends State<ConquestArea> {
  int acceptedDataX = 100;
  int acceptedDataY = 100;
  int changeValue = 0;
  int correctionValue = 0;
  late Field field;

  @override
  void initState() {
    super.initState();

    field = Field(index: widget.fieldIndex);
    field.setField();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      builder: (context, candidateItems, _) {
        return AnimatedScale(
          scale: candidateItems.isNotEmpty ? 1.1 : 1.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
          child: Card(
            color: field.isConquested != null
                ? widget.initialColor.withValues(alpha: 0.5)
                : candidateItems.isNotEmpty
                ? widget.initialColor.withValues(alpha: 0.8)
                : widget.initialColor,
            elevation: 5,
            shadowColor: widget.initialColor.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: AppThemes.stdBorderRadius,
            ),
            child: Column(
              mainAxisAlignment: .spaceEvenly,
              children: <Widget>[
                Text(
                  "${field.fieldSelected}",
                  style: TextStyle(
                    color: widget.initialColor == Colors.black
                        ? AppThemes.white
                        : AppThemes.black,
                    fontWeight: .w600,
                  ),
                ),
                if (widget.defenseEmoji != null) ...[
                  Text(
                    "${widget.defenseEmoji?.emoji}  ${correctedDamage()} atk",
                    style: TextStyle(
                      color: widget.initialColor == Colors.black
                          ? AppThemes.white
                          : AppThemes.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                Text(
                  "X: $acceptedDataX / Y: $acceptedDataY",
                  style: TextStyle(
                    color: widget.initialColor == Colors.black
                        ? AppThemes.white
                        : AppThemes.black,
                    fontWeight: .w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      onAcceptWithDetails: (details) {
        widget.player.play(audio: .placement);
        checkDefenseEmoji();
        if (field.isConquested == true) {
          widget.player.play(audio: .error);
          return;
        }

        changeValue = details.data["color"] == widget.initialColor
            ? Player.changeValue()
            : 0;
        changeValue -= details.data["attack"] as int;
        changeValue += field.getAdjustmentFieldDamage(
          details.data["emoji_class"],
        );

        if (details.data["player"] == "X") {
          if (!attackDefense(
            details.data["attack"],
            details.data["player"],
            details.data["emoji_class"],
            field.defenseEmojiOwner,
          )) {
            acceptedDataX += changeValue <= 0 ? changeValue : 0;

            if (acceptedDataX <= 0) updateFieldState(details.data["player"]);
          }
        } else {
          if (!attackDefense(
            details.data["attack"],
            details.data["player"],
            details.data["emoji_class"],
            field.defenseEmojiOwner,
          )) {
            acceptedDataY += changeValue <= 0 ? changeValue : 0;

            if (acceptedDataY <= 0) updateFieldState(details.data["player"]);
          }
        }
        widget.updateGameTurn(field.playerConquested);
        setState(() {});
      },
    );
  }

  void checkDefenseEmoji() {
    if (widget.defenseEmoji != null) {
      if (field.containDefenseEmoji == true) return;
      field.containDefenseEmoji = true;
      field.defenseEmojiOwner = widget.getDefenseEmojiOwner();
    }
  }

  int correctedDamage() {
    if (widget.defenseEmoji != null) {
      if (widget.defenseEmoji!.attack == 0) return 0;
      correctionValue =
          field.getAdjustmentFieldDamage(widget.defenseEmoji!.emojiType) * (-1);
      correctionValue += widget.defenseEmoji?.attack as int;
      return correctionValue < 0 ? 1 : correctionValue;
    }
    correctionValue = widget.defenseEmoji?.attack as int;
    return correctionValue;
  }

  bool attackDefense(
    int attack,
    String player,
    EmojiType emojiPlayer,
    String? emojiOwner,
  ) {
    if (emojiOwner == null) return false;

    if (widget.defenseEmoji != null) {
      if (widget.defenseEmoji!.attack == 0) return false;

      if (player != emojiOwner) {
        correctionValue += EmojisInfo.getAdjustmentEmojiDamage(
          defenseEmoji: widget.defenseEmoji!.emojiType,
          attackerEmoji: emojiPlayer,
        );

        if ((correctionValue) <= attack) {
          widget.removeDefenseEmoji(index: player == "X" ? 1 : 0, removeAttacker: true);
          player == "X"
              ? acceptedDataX -= (attack - correctionValue)
              : acceptedDataY -= (attack - correctionValue);
          return true;
        } else {
          widget.removeDefenseEmoji(index: player == "X" ? 0 : 1, removeAttacker: false);
          return true;
        }
      }
    }
    return false;
  }

  void updateFieldState(String player) {
    field.isConquested = true;
    field.playerConquested = player;

    if (player == "X") {
      acceptedDataX = 0;
    } else {
      acceptedDataY = 0;
    }
  }
}
